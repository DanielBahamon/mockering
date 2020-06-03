class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_devise_params, if: :devise_controller?


  protected

  def configure_devise_params
  	devise_parameter_sanitizer.permit(:sign_up) do |mocker|
  		mocker.permit(:first_name, :last_name, :email, :birthday, :password, :password_confirmation, :slug)
  	end
  	devise_parameter_sanitizer.permit(:account_update) do |mocker|
  		mocker.permit(:first_name, :last_name, :email, :birthday, :password, :password_confirmation, :slug, :bio)
  	end
  end

  # def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :bio, :birthday, :slug])
    # devise_parameter_sanitizer.permit(:account_update, keys: [ :email, :first_name, :last_name, :bio, :birthday, :slug, :password, :password_confirmation])
  # end

end
