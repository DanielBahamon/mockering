class RegistrationsController < Devise::RegistrationsController
  protected
  def update_resource(resource, params)
  	if params[:password].present?
      resource.password = params[:password]
      resource.password_confirmation = params[:password_confirmation]
    end
   	resource.update_without_password(params)
  end
end
