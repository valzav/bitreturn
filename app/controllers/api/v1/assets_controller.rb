module Api
  module V1

    class AssetsController < ApiController

      def index
        assets = Asset.all
        render json: assets, status: :ok, root: false
      end

      def create
        invalid_date = false
        if params[:asset][:effective_date] =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)/
          begin
            params[:asset][:effective_date] = Date.new($3.to_i, $1.to_i, $2.to_i)
          rescue ArgumentError
            invalid_date = true
          end
        end
        asset = Asset.create(params[:asset].merge(user: current_user))
        asset.errors.add(:effective_date, "date format should be 'MM/DD/YYYY'") if invalid_date
        if asset.errors.empty?
          render json: asset, status: :ok, root: false
        else
          render json: asset.errors, status: :unprocessable_entity
        end
      end

      def update
        invalid_date = false
        if params[:asset][:effective_date] =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)/
          begin
            params[:asset][:effective_date] = Date.new($3.to_i, $1.to_i, $2.to_i)
          rescue ArgumentError
            invalid_date = true
          end
        end
        asset = current_user.assets.find(params[:id])
        asset.update_attributes(params[:asset])
        asset.errors.add(:effective_date, "date format should be 'MM/DD/YYYY'") if invalid_date
        if asset.errors.empty?
          render json: asset, status: :ok, root: false
        else
          render json: asset.errors, status: :unprocessable_entity
        end
      end

      def destroy
        asset = current_user.assets.find(params[:id])
        asset.destroy
        head :no_content
      end

    end
  end
end
