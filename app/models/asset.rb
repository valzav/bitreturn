require 'open-uri'
require 'json'

class Asset < ActiveRecord::Base
  belongs_to :user
  belongs_to :assetable, polymorphic: true
  attr_accessible :name, :assetable, :quantity, :purchase_date, :effective_date
  attr_accessible :user, :currency, :price, :ghps, :power_use_watt

  monetize :price_cents

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

  def btc_price
    return price.to_f if currency == 'BTC'
    @btc_ticker ||= MarketEnv.get_usd_btc_rate
    return price.to_f / @btc_ticker
  end

  def analyze(blocks, market_env, end_date)
    Asset.analyze_miner(self, blocks, market_env, end_date)
  end

  def self.combine_results(results)
    sum = AnalysisResult.new
    sum.power_cost = 0.0
    sum.pool_fee = 0.0
    sum.gross_income = 0.0
    sum.expenses = 0.0
    sum.net_income = 0.0
    sum.asset_btc_price = 0.0

    cashflows = Hash.new(0.0)
    results.each do |r|
      sum.power_cost += r.power_cost
      sum.pool_fee += r.pool_fee
      sum.gross_income += r.gross_income
      sum.expenses += r.expenses
      sum.net_income += r.net_income
      sum.asset_btc_price += r.asset_btc_price
      r.cashflows.each {|d,v| cashflows[d] += v }
    end
    sum.cashflows = cashflows.sort{|e|e[0]}
    if sum.asset_btc_price > 0.0
      sum.roi = (sum.net_income - sum.asset_btc_price) / sum.asset_btc_price
    else
      sum.roi = 0.0
    end
    #p sum
    sum
  end

  def self.analyze_miner(asset, blocks, market_env, end_date)
    btc_sum = 0.0
    pool_fee_btc = 0.0
    power_cost = 0.0
    cashflow = []
    blocks.each do |b|
      logger.debug b.inspect
      next if b.date < asset.effective_date
      break if b.date > end_date
      difficulty = b.difficulty || b.f_difficulty
      time_per_block = BitcoinDifficultyModel.calc_time_per_block(difficulty, asset.ghps)
      blocks_per_24h = 24*3600/time_per_block
      btc_per_24h = blocks_per_24h * 25
      btc_sum += btc_per_24h
      power_cost += asset.power_use_watt * 24 * market_env.power_cost / 1000.0
      pool_fee_btc += btc_per_24h * market_env.pool_fee
      cashflow << [b.date.to_s(:number).to_i, (btc_sum - power_cost - pool_fee_btc).round(3)]
      #puts "#{b[:date]} difficulty: #{b[:difficulty]} #{time_per_block} #{btc_per_24h}"
      #puts "btc_sum: #{btc_sum}, power_used: #{power_used}, pool_fee_btc: #{pool_fee_btc}"
    end
    result = AnalysisResult.new
    result.power_cost = power_cost
    result.pool_fee = pool_fee_btc
    result.gross_income = btc_sum
    result.expenses = result.power_cost - result.pool_fee
    result.net_income = result.gross_income - result.expenses
    result.roi = (result.net_income - asset.btc_price) / asset.btc_price
    result.asset_btc_price = asset.btc_price
    result.cashflows = cashflow
    return result
  end

  def self.calc_security_cashflows(asset, blocks, params)
    date = params.start_date
    end_date = params.end_date

    avg_dividends = 0.0
    if asset.dividends_history.length < 5
      avg_dividends = asset.dividends_history.last[1]
    else
      avg_dividends = asset.dividends_history[-5..-1].inject(0.0){|s,d| s += d[1]; s}/5.0
    end
    puts "avg_dividend: #{avg_dividends}"

    last_dividends_day = Date.parse(asset.dividends_history.last[0])

    dividends = 0.0
    while date <= end_date
      #puts date
      if ((date - last_dividends_day).to_i % asset.dividends_frequency == 0)
        dividends += asset.quantity * avg_dividends
        #puts "dividents: #{date.to_s}, dividends #{dividends}"
      end
      date += 1
    end
    result = OpenStruct.new
    result.dividends = dividends
    result.original_investment = asset.quantity * asset.price
    result.gross_btc = result.original_investment + dividends
    result.net_btc = result.gross_btc
    result.roi = (result.gross_btc - result.original_investment) / result.original_investment
    return result
  end

end
