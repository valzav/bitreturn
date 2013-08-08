class MarketEnv < ActiveRecord::Base
  attr_accessible :usd_btc_rate, :power_cost, :pool_fee

  def self.get_usd_btc_rate
    ticker_url = 'http://data.mtgox.com/api/1/BTCUSD/ticker_fast'
    json = JSON.parse(open(ticker_url).read)
    return json['return']['last_local']['value'].to_f
  end

end
