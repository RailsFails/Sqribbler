class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :show_welcome

  def http_referer_uri
    request.env["HTTP_REFERER"] && URI.parse(request.env["HTTP_REFERER"])
  end

  def refered_from_our_site?
    if uri = http_referer_uri
      uri.host == request.host
    end
  end

  def show_welcome
    if !refered_from_our_site? && http_referer_uri
      flash[:notice] = 'Welcome to scribbler'
    end
    #flash[:alert] = 'alert'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end
