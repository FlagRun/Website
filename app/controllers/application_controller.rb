class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  #after_filter :verify_authorized, except: :index
  #after_filter :verify_policy_scoped, only: :index
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end
