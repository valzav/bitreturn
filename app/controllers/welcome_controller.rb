require Rails.root.join('lib/bitcoin_difficulty_model.rb').to_s
require 'active_model_serializers'

class WelcomeController < ApplicationController
  respond_to :html, :js

  def index

    dm = DifModel.new(monthly_growth: 40, investment_horizon: 6)
    dm.forecast!
    assets = Asset.all
    asset = assets.first
    asset.effective_date = Date.today

    market = MarketEnv.new ({
      usd_btc_rate: MarketEnv.get_usd_btc_rate,
      power_cost: 0.15 / MarketEnv.get_usd_btc_rate,
      pool_fee: 0.02,
    })

    result = asset.analyze(dm.model.blocks, market, dm.model.horizon_date)

    gon.user = 'vz'
    gon.miners = Miner.all.map { |m| m.serializer }
    gon.assets = assets.map { |m| m.serializer }
    gon.dm = dm.serializer
    gon.result = result.serializer
    render :index, layout: 'jsapp'
  end

  def blocks
    dm = DifModel.new(monthly_growth: 40, investment_horizon: 6)
    dm.forecast!
    gon.dm = dm.serializer
  end

  def flatui
    render :flatui, layout: false
  end

end
