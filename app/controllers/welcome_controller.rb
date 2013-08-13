require Rails.root.join('lib/bitcoin_difficulty_model.rb').to_s
require 'active_model_serializers'

class WelcomeController < ApplicationController
  respond_to :html, :js

  def index
    user = current_user || login_anonymous_user
    market =  user.market_env || MarketEnv.new(monthly_growth: 40, investment_horizon: 6)
    market.forecast!
    assets = Asset.all
    asset = assets.first
    asset.effective_date = Date.today
    result = asset.analyze(market.model.blocks, market, market.model.horizon_date)

    gon.user = user.serializer
    gon.miners = Miner.all.map { |m| m.serializer }
    gon.assets = assets.map { |m| m.serializer }
    gon.market = market.serializer
    gon.result = result.serializer
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
