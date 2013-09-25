module Api
  module V1

    class AnalysisResultsController < ApiController
      skip_before_filter :require_user

      def create
        market = current_user.market_env
        res = market.forecast
        results = []
        current_user.assets.each do |a|
          results << a.analyze(res[:blocks], market, res[:horizon_date])
        end
        res = Asset.combine_results(results)
        if res.errors.empty?
          render json: res, status: :ok, root: false
        else
          render json: res.errors, status: :unprocessable_entity, root: false
        end
      end

    end

  end
end
