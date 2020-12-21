class RegistrationsController < Devise::RegistrationsController

  prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

  private
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        resource.validate # Look for any other validation errors besides reCAPTCHA
        set_minimum_password_length
        respond_with_navigational(resource) { render :new }
      end 
    end
    
  protected
	  def update_resource(resource, params)
	  	if params[:password].present?
	      resource.password = params[:password]
	      resource.password_confirmation = params[:password_confirmation]
	    end
	   	resource.update_without_password(params)
	  end
end
