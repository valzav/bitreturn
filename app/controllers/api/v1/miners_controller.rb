class Api::V1::MinersController < ApplicationController

  def index
    miners = Miner.all
    render json: miners, status: :ok, root: false
  end


end
