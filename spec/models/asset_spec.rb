require 'spec_helper'
require 'ostruct'

describe Asset do

  let(:miner1) do
    Asset.create ({
      name: 'BFL Jalapeno 7 Gh/s',
      quantity: 1,
      currency: 'USD',
      price: 240,
      ghps: 7,
      power_use_watt: 30,
      purchase_date: Date.parse('2013-09-01'),
      effective_date: Date.parse('2013-09-01')
    })
  end

  let(:miner2) do
    Asset.create ({
      name: 'Butterfly Labs 25 GH/s SC',
      quantity: 1,
      currency: 'USD',
      price: 1249,
      ghps: 25,
      power_use_watt: 150,
      purchase_date: Date.parse('2013-09-01'),
      effective_date: Date.parse('2013-09-01')
    })
  end

  let(:market_env) do
    MarketEnv.create ({
      usd_btc_rate: MarketEnv.get_usd_btc_rate,
      power_cost: 0.15 / MarketEnv.get_usd_btc_rate,
      pool_fee: 0.02
    })
  end

  it 'should be able to analyze mining asset' do
    MarketEnv.stub(:get_usd_btc_rate){ 100.0 }
    end_date = Date.parse('2014-08-17')
    blocks = load_yaml('blocks_forecast.yml').map{|b| OpenStruct.new(b) }
    result = miner1.analyze(blocks, market_env, end_date)
    #puts result.inspect
    result.power_cost.should be_within(0.01).of(0.34)
    result.pool_fee.should be_within(0.01).of(0.13)
    result.roi.should be_within(0.001).of(1.736)
  end

  it 'should be able to analyze mining asset with quantity' do
    MarketEnv.stub(:get_usd_btc_rate) { 100.0 }
    end_date = Date.parse('2014-08-17')
    blocks = load_yaml('blocks_forecast.yml').map { |b| OpenStruct.new(b) }
    m = miner1
    result1 = m.analyze(blocks, market_env, end_date)
    m.quantity = 10
    result2 = m.analyze(blocks, market_env, end_date)
    #result.power_cost.should be_within(0.01).of(0.34)
    #result.pool_fee.should be_within(0.01).of(0.13)
    result1.gross_income.should be_within(0.001).of(result2.gross_income/10.0)
    result2.roi.should be_within(0.001).of(result1.roi)
  end

  it 'should be able to combine results' do
    MarketEnv.stub(:get_usd_btc_rate) { 100.0 }
    end_date = Date.parse('2014-08-17')
    blocks = load_yaml('blocks_forecast.yml').map { |b| OpenStruct.new(b) }
    result1 = miner1.analyze(blocks, market_env, end_date)
    result2 = miner2.analyze(blocks, market_env, end_date)
    #puts result1.inspect
    #puts result2.inspect
    Asset.combine_results([result1,result2])
    #result.power_cost.should be_within(0.01).of(0.34)
    #result.pool_fee.should be_within(0.01).of(0.13)
    #result.roi.should be_within(0.001).of(1.736)
  end

  it 'should be able to analyze bond' do
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
