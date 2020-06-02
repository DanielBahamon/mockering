class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @mocker = Mocker.from_omniauth(request.env["omniauth.auth"])

    if @mocker.persisted?
      sign_in_and_redirect @mocker, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_mocker_registration_url
    end
  end
end