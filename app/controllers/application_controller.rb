class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'webapp'

  helper :all
  helper_method :current_user_session, :current_user, :decorate
  before_filter :set_locale

  private

  def sign_in_and_redirect(user)
    @user_session = UserSession.new
    @user_session.credentials = [user, true]
    if @user_session.save
      @current_user = @user_session.user
      if @current_user.test_user?
        redirect_to app_path
      else
        redirect_to root_path
      end
    else
      logger.error "!!! @user_session.save error: #{@user_session.errors.inspect}"
      flash[:notice] = "Cannot sign in user"
      redirect_to root_path
    end
  end

  def get_user_by_facebook_access_token(token=nil)
    @access_token = token || params[:access_token]
    @koala = Koala::Facebook::API.new(@access_token)
    @fb_user = @koala.get_object("me")
    unless @fb_user
      logger.warn("!!! get_user_by_facebook_access_token problem. token: #{@access_token}'")
      return
    end
    @fb_user.merge!('uid' => @fb_user["id"], 'provider' => 'facebook')
    @omniauth = {
      "uid" => @fb_user['uid'],
      "provider" => @fb_user['provider'],
      "info" => {
        "nickname" => @fb_user['username'],
        "email" => @fb_user['email'],
        "name" => @fb_user['name'],
        "first_name" => @fb_user['first_name'],
        "last_name" => @fb_user['last_name'],
        "image" => @fb_user['image'],
        "urls" => {
          'Facebook' => @fb_user['link']
        }
      },
      "credentials" => {
        "token" => @access_token,
        "expires" => false
      }
    }
    @user = User.get_user_for_login_via_omniauth(@omniauth, current_user, Fbapp.rmenu)
  end

  #def get_user_for_phonegap_login
  #  temp_email = "#{Time.now.to_i}.#{(0...5).map { 65.+(rand(25)).chr }.join}@example.com"
  #  user = User.create(email: temp_email, name: 'phonegap')
  #  user.active = true
  #  user.save!
  #  return user
  #end
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      flash[:notice] = 'You must be logged in to access this page'
      if request.xhr?
        render json: 'User is not authenticated', status: 401
      else
        respond_to do |format|
          format.json { render json: 'User is not authenticated', status: 401 }
          format.html { redirect_to root_path }
        end
      end
      return false
    end
    if current_user
      gon.user = current_user.serializer
    end
  end

  def require_no_user
    if current_user
      flash.now[:notice] = "You must be logged out to access this page"
      redirect_to root_path
      return false
    end
  end

  def require_admin_user
    return false unless require_user
    return true if current_user.admin?
    flash.now[:notice] = "You are not authorized to access this page"
    redirect_to root_path
    return false
  end

  def require_fb_user
    unless current_user
      session[:return_to] = request.fullpath
      redirect_to "/auth/facebook"
      return false
    end
  end

  def check_if_canvasapp
    return if (@canvasapp = session[:canvasapp])
    if params[:signed_request]
      @canvasapp = session[:canvasapp] = true
      signed_request = Fbapp.main.parse_signed_request(params[:signed_request])
      logger.debug("-------------- canvasapp ---- signed_request #{signed_request}")
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    if session[:return_to]
      redirect_to session[:return_to]
      session[:return_to] = nil
    elsif request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end

  def set_locale
    #Phrase.DomObserver.reparseElement($('#wizard-content-region'))
    #{{__phrase_homepage.main.headline__}}
    @phrase_js_on = false
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def dom_id_to_model(str)
    str =~ /(.*?)_(\d+)$/
    class_name, id = $1, $2
    class_name.classify.constantize.find(id)
  end

end
