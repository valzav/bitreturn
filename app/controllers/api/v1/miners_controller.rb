class Api::V1::MinersController < ApplicationController

  def index
    miners = Miner.all
    render json: miners, status: :ok, root: false
  end

  #def create
  #  dif_model = DifModel.new(params[:dif_model])
  #  dif_model.forecast!
  #  render json: dif_model, status: :ok, root: false
  #end

end
