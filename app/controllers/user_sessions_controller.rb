class UserSessionsController < ApplicationController
  before_filter :require_user, :only => :destroy
  respond_to :html

  def new
    @user_session = UserSession.new(:remember_me => true)
    @no_navbar_login_box = true
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        @current_user = @user_session.user
        redirect_to dashboard_path
      else
        flash.now[:error] = "Incorrect email or password."
        render :action => :new
      end
    end
  end

  def destroy
    current_user_session.destroy
    flash.now[:notice] = "You have been logged out."
    redirect_to root_path
  end

end
