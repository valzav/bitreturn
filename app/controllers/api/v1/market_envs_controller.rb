class Api::V1::MarketEnvsController < ApplicationController

  def create
    market = MarketEnv.create(params[:market_env].merge(user: current_user))
    market.forecast!
    render json: market, status: :ok, root: false
  end

  def update
    market = MarketEnv.find(params[:id])
    market.update_attributes(params[:market_env])
    market.forecast!
    render json: market, status: :ok, root: false
  end

end
