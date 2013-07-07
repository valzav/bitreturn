module Api
  module V1

    class VisitorActionsController < ApiController
      skip_before_filter :require_user

      def create
        va = VisitorAction.new(params[:visitor_action])
        va.ua = request.env['HTTP_USER_AGENT']
        va.ip = request.remote_ip
        if va.save
          render json: va, status: :ok, root: false
        else
          render json: va.errors, status: :unprocessable_entity, root: false
        end
      end

    end

  end
end
