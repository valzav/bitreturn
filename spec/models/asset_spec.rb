require 'spec_helper'
require 'ostruct'

require Rails.root.join('lib/bitcoin_difficulty_model.rb').to_s

describe Asset do

  it 'should be able to generate cash flows' do

    params = OpenStruct.new
    params.usd_btc_ticker = Asset.get_usd_btc_ticker
    params.power_cost = 0.15
    params.pool_fee = 0.02
    params.start_date = Date.parse('2013-09-01')
    params.end_date = Date.parse('2014-08-17')

    asset = OpenStruct.new
    asset.ghps = 7
    asset.price = 240
    asset.start_date = params.start_date
    asset.btc_price = asset.price / params.usd_btc_ticker
    asset.power_use = 30

    puts "BTC price #{asset.btc_price}, usd/btc ticker: #{params.usd_btc_ticker}"

    blocks = load_yaml('blocks_forecast.yml')
    result = Asset.calc_mining_cashflows(asset, blocks, params)

    puts result.inspect

    params.start_date = Date.parse('2013-09-01')
    params.investment_amount = 240 / params.usd_btc_ticker
    asset = OpenStruct.new
    asset.name = 'TAT.ASICMINER'
    asset.price = 0.04489900
    #asset.name = 'BASIC-MINING'
    #asset.price = 0.73
    asset.quantity = ((240 / params.usd_btc_ticker) / asset.price).to_i
    asset.dividends_frequency = 1
    #asset.dividends_history = [
    #  ['2013-07-17',0.00024099],
    #  ['2013-07-10',0.00019717],
    #  ['2013-07-03',0.00021822],
    #  ['2013-06-26',0.00018412],
    #  ['2013-06-19',0.00017196]
    #]
    asset.dividends_history = [
      ['2013-07-18', 0.00011251],
      ['2013-07-17', 0.00011756],
      ['2013-07-16', 0.00011483],
      ['2013-07-15', 0.00011822],
      ['2013-07-14', 0.00011711]
    ]
    result = Asset.calc_security_cashflows(asset, blocks, params)
    puts result.inspect

  end


end
