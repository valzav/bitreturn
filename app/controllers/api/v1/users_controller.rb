module Api
  module V1

    class UsersController < ApiController

      def update
        user = current_user
        if !params[:user][:password].blank? and params[:user][:password_confirmation].blank?
          params[:user][:password_confirmation] = params[:user][:password]
        end
        user.update_attributes(params[:user])
        user.errors.add(:password, "can't be blank.") if params[:user][:password].blank?
        if user.errors.empty?
          render json: user, status: :ok, root: false
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

    end
  end
end
