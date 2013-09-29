require 'active_model_serializers'
require 'bitcoin_difficulty_model'

class WelcomeController < ApplicationController
  respond_to :html, :js

  def index
    user = current_user
    unless user
      user = login_anonymous_user
      miner = Miner.where(name: 'ASICMiner Block Erupter USB').first
      asset_attrs = {
        name: miner.name,
        assetable: miner,
        quantity: 10,
        currency: miner.currency,
        price: miner.price,
        ghps: miner.ghps,
        power_use_watt: miner.power_use_watt,
        effective_date: (Time.now + (7*24*60*60)).to_date
      }
      user.assets.create!(asset_attrs)
      user.market_env = MarketEnv.new(monthly_growth: 80, investment_horizon: 6)
    end
    market =  user.market_env
    res = market.forecast
    results = []
    user.assets.each do |a|
      results << a.analyze(res[:blocks], market, res[:horizon_date])
    end
    sum = Asset.combine_results(results)
    #logger.debug sum.cashflows
    gon.user = user.serializer
    gon.miners = Miner.all.map { |m| m.serializer }
    gon.assets = user.assets.map { |a| a.serializer }
    gon.market = market.serializer
    gon.result = sum.serializer
    render :index, layout: 'jsapp'
  end

  def blocks
    market = MarketEnv.new(monthly_growth: 40, investment_horizon: 6)
    market.forecast!
    gon.market = market.serializer
  end

  def flatui
    render :flatui, layout: false
  end

end
