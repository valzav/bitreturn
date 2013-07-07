class UsersController < ApplicationController
  before_filter :require_user, :except => [:new, :create]
  respond_to :html
  
  def dashboard

  end

  def new
    @user = User.new
    @no_navbar_login_box = true
  end

  def create
    @user = User.new(params[:user])
    @user.active = true
    if @user.save
      @current_user = @user
      redirect_to dashboard_path
    else
      #flash[:error] = @user.errors.full_messages.join('; ')
      render :action => :new
    end
  end

  def edit
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = 'The settings were successfully updated'
      redirect_back_or_default dashboard_path
    end
  end

  def destroy
    current_user_session.destroy
    current_user.destroy
    flash[:notice] = "Account deleted!"
    redirect_to user_path(current_user)
  end

  private

end
