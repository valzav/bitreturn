class Api::V1::AssetsController < ApplicationController

  def index
    assets = Asset.all
    render json: assets, status: :ok, root: false
  end

  def create
    asset = Asset.create(params[:asset].merge(user: current_user))
    render json: asset, status: :ok, root: false
  end

  def update
    asset = current_user.assets.find(params[:id])
    asset.update_attributes(params[:asset])
    render json: asset, status: :ok, root: false
  end

  def destroy
    asset = current_user.assets.find(params[:id])
    asset.destroy
    head :no_content
  end

end
