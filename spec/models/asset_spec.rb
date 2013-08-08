require 'spec_helper'
require 'ostruct'

require Rails.root.join('lib/bitcoin_difficulty_model.rb').to_s

describe Asset do

  it 'should be able to generate cash flows' do

    market_env = MarketEnv.create!({
       usd_btc_rate: MarketEnv.get_usd_btc_rate,
       power_cost: 0.15,
       pool_fee: 0.02,
    })
    puts market_env.inspect
    end_date = Date.parse('2014-08-17')

    #asset = OpenStruct.new
    #asset.ghps = 7
    #asset.price = 240
    #asset.start_date = params.start_date
    #asset.btc_price = asset.price / params.usd_btc_rate
    #asset.power_use = 30

    asset = Asset.create!({
                            name: 'BFL Jalapeno 7 Gh/s',
                            quantity: 1,
                            currency: 'USD',
                            price: 240,
                            ghps: 7,
                            power_use_watt: 30,
                            purchase_date: Date.parse('2013-09-01'),
                            effective_date: Date.parse('2013-09-01')
                          })

    puts "Price #{asset.btc_price} BTC, usd/btc ticker: #{market_env.usd_btc_rate}"

    blocks = load_yaml('blocks_forecast.yml')
    result = Asset.calc_mining_cashflows(asset, blocks, market_env, end_date)
    puts result.inspect

    #params.start_date = Date.parse('2013-09-01')
    #params.investment_amount = 240 / params.usd_btc_rate
    #asset = OpenStruct.new
    #asset.name = 'TAT.ASICMINER'
    #asset.price = 0.04489900
    #asset.quantity = ((240 / params.usd_btc_rate) / asset.price).to_i
    #asset.dividends_frequency = 1
    #asset.dividends_history = [
    #  ['2013-07-18', 0.00011251],
    #  ['2013-07-17', 0.00011756],
    #  ['2013-07-16', 0.00011483],
    #  ['2013-07-15', 0.00011822],
    #  ['2013-07-14', 0.00011711]
    #]
    #result = Asset.calc_security_cashflows(asset, blocks, params)
    #puts result.inspect

  end


end
