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
    asset = Asset.find(params[:id])
    asset.update_attributes(params[:asset])
    render json: asset, status: :ok, root: false
  end


end
