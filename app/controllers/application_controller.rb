class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  skip_before_action :verify_authenticity_token, if: -> { Rails.env.test? }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password, :password_confirmation, :role ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :email, :password, :password_confirmation, :role ])
  end
end
