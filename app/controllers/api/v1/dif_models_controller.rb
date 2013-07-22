class Api::V1::DifModelsController < ApplicationController

  def create
    dif_model = DifModel.new(params[:dif_model])
    dif_model.forecast!
    render json: dif_model, status: :ok, root: false
  end

end
