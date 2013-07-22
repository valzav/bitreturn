require Rails.root.join('lib/bitcoin_difficulty_model.rb').to_s

class WelcomeController < ApplicationController
  respond_to :html, :js

  def index
    gon.user = 'vz'

    dm = DifModel.new(monthly_growth: 40)
    dm.forecast!
    gon.dm = dm.serializer
    #gon.data_hashes = dm.data_hashes
    #gon.data_difficulty = dm.data_difficulty
    #gon.data_f_hashes = dm.data_f_hashes
    #gon.data_f_difficulty = dm.data_f_difficulty


    render :index, layout: 'jsapp'
  end

  def blocks


  end

  def flatui
    render :flatui, layout: false
  end

end
