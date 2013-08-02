class Api::V1::AssetsController < ApplicationController

  def index
    assets = Asset.all
    render json: assets, status: :ok, root: false
  end

  #def create
  #  dif_model = DifModel.new(params[:dif_model])
  #  dif_model.forecast!
  #  render json: dif_model, status: :ok, root: false
  #end

end
