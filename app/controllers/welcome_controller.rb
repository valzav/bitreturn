require Rails.root.join('lib/bitcoin_difficulty_model.rb').to_s
require 'active_model_serializers'

class WelcomeController < ApplicationController
  respond_to :html, :js

  def index
    gon.user = 'vz'
    gon.miners = Miner.all.map { |m| m.serializer }
    gon.assets = Asset.all.map { |m| m.serializer }
    dm = DifModel.new(monthly_growth: 40, investment_horizon: 6)
    dm.forecast!
    gon.dm = dm.serializer
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
