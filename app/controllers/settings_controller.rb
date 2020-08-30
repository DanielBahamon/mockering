class SettingsController < ApplicationController
	def edit
		@setting = Mocker.find(current_mocker.id).setting
	end

	def update
		@setting = Mocker.find(current_mocker.id).setting
		if @setting.update(setting_params)
			flash[:notice] = "Great!"
		else
			flash[:alert] = "Ops! Try again."
		end
		render 'edit'
	end


	
	private

	def setting_params
		params.require(:setting).permit(:enable_sms, :enable_email, :mocker_id)
	end

end
