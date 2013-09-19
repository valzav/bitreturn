module Api
  module V1

    class MinersController < ApiController

      def index
        miners = Miner.all
        render json: miners, status: :ok, root: false
      end

    end

  end
end
