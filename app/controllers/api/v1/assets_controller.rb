module Api
  module V1

    class AssetsController < ApiController

      def index
        assets = Asset.all
        render json: assets, status: :ok, root: false
      end

      def create
        if params[:asset][:effective_date] =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)/
          params[:asset][:effective_date] = Date.new($3.to_i, $1.to_i, $2.to_i)
        end
        asset = Asset.create(params[:asset].merge(user: current_user))
        render json: asset, status: :ok, root: false
      end

      def update
        if params[:asset][:effective_date] =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)/
          params[:asset][:effective_date] = Date.new($3.to_i, $1.to_i, $2.to_i)
        end
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
  end
end
