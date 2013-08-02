require 'open-uri'
require 'json'

class Asset < ActiveRecord::Base
  belongs_to :user
  belongs_to :assetable, polymorphic: true
  attr_accessible :name, :assetable, :quantity, :purchase_date, :effective_date

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

  def self.get_usd_btc_ticker
    ticker_url = 'http://data.mtgox.com/api/1/BTCUSD/ticker_fast'
    json = JSON.parse(open(ticker_url).read)
    return json['return']['last_local']['value'].to_f
  end

  def self.calc_mining_cashflows(asset, blocks, params)
    btc_sum = 0.0
    power_used = 0.0
    pool_fee_btc = 0.0
    end_date = params.end_date
    blocks.each do |b|
      next if b[:date] < asset.start_date
      break if b[:date] > end_date
      time_per_block = BitcoinDifficultyModel.calc_time_per_block(b[:difficulty], asset.ghps)
      blocks_per_24h = 24*3600/time_per_block
      btc_per_24h = blocks_per_24h * 25
      btc_sum += btc_per_24h
      power_used += asset.power_use * 24
      pool_fee_btc += btc_per_24h * params.pool_fee
      #puts "#{b[:date]} difficulty: #{b[:difficulty]} #{time_per_block} #{btc_per_24h}"
    end
    result = OpenStruct.new
    result.power_cost_usd = power_used * params.power_cost / 1000.0
    result.power_cost_btc = result.power_cost_usd / params.usd_btc_ticker
    result.pool_fee_btc = pool_fee_btc
    result.gross_btc = btc_sum
    result.net_btc = btc_sum - result.power_cost_btc - result.pool_fee_btc
    result.roi = (result.net_btc - asset.btc_price) / asset.btc_price
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
