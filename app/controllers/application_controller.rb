class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_devise_params, if: :devise_controller?
  before_action :set_search

  helper_method :is_admin!



  def set_search
    @search = Mock.ransack(params[:q])
    @q = Mock.ransack(params[:q])
    @mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 30).where(privated: false)
  end


  protected

  def configure_devise_params

  	devise_parameter_sanitizer.permit(:sign_up) do |mocker|
  		mocker.permit(:first_name, :last_name, :email, :birthday, :password, :password_confirmation, :slug, :remember_me)
  	end
  	devise_parameter_sanitizer.permit(:account_update) do |mocker|
  		mocker.permit(:first_name, :last_name, :email, :birthday, :password, :password_confirmation, :slug, 
                    :bio, :photo, :tag_list, :coverpage, :facebook, :twitter, :instagram, :pinterest, :youtube,
                    :phone_number, :privated, :show_mocks_privated)
  	end
  end

  # def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :bio, :birthday, :slug])
    # devise_parameter_sanitizer.permit(:account_update, keys: [ :email, :first_name, :last_name, :bio, :birthday, :slug, :password, :password_confirmation])
  # end

  def is_admin!
    unless current_mocker&.admin
      redirect_to root_path
    end
  end

end
