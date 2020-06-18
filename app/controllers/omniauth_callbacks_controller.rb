class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/mocker.rb)
    @mocker = Mocker.from_omniauth(request.env["omniauth.auth"])

    if @mocker.persisted?
      sign_in_and_redirect @mocker, event: :authentication #this will throw if @mocker is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_mocker_registration_url
    end
  end

  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/mocker.rb)
      @mocker = Mocker.from_omniauth(request.env['omniauth.auth'])

      if @mocker.persisted?
        sign_in_and_redirect @mocker, event: :authentication #this will throw if @mocker is not activated
        set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_mocker_registration_url, alert: @mocker.errors.full_messages.join("\n")
      end
  end
end