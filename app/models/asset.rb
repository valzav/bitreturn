require 'open-uri'
require 'json'

class Asset < ActiveRecord::Base
  belongs_to :user
  belongs_to :assetable, polymorphic: true
  attr_accessible :name, :assetable, :quantity, :purchase_date, :effective_date
  attr_accessible :currency, :price, :ghps, :power_use_watt

  monetize :price_cents

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

  def btc_price
    return price.to_f if currency == 'BTC'
    @btc_ticker ||= MarketEnv.get_usd_btc_rate
    return price.to_f / @btc_ticker
  end

  def self.calc_mining_cashflows(asset, blocks, market_env, end_date)
    puts market_env.inspect
    btc_sum = 0.0
    power_used = 0.0
    pool_fee_btc = 0.0
    blocks.each do |b|
      next if b[:date] < asset.effective_date
      break if b[:date] > end_date
      time_per_block = BitcoinDifficultyModel.calc_time_per_block(b[:difficulty], asset.ghps)
      blocks_per_24h = 24*3600/time_per_block
      btc_per_24h = blocks_per_24h * 25
      btc_sum += btc_per_24h
      power_used += asset.power_use_watt * 24
      pool_fee_btc += btc_per_24h * market_env.pool_fee
      #puts "#{b[:date]} difficulty: #{b[:difficulty]} #{time_per_block} #{btc_per_24h}"
      #puts "power_used: #{power_used}, pool_fee_btc: #{pool_fee_btc}"
    end
    result = AnalysisResult.new
    result.power_cost = (power_used * market_env.power_cost / 1000.0) / market_env.usd_btc_rate
    result.pool_fee = pool_fee_btc
    result.gross_income = btc_sum
    result.net_income = btc_sum - result.power_cost - result.pool_fee
    result.roi = (result.net_income - asset.btc_price) / asset.btc_price
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
