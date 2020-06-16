class MockersController < ApplicationController
	before_action :authenticate_mocker!, except: [:show, :username_validator]
   	before_action :set_mocker, only: [:show, :edit, :update, :destroy]
	

	def show
    	@mocker = Mocker.friendly.find(params[:id])
    	# @mocks = @mocker.mocks
	end

	def index
	end

	def update
		@mocker.update(new_params)

		if @mocker.update(mocker_params)
			redirect_to @mocker, notice: "Mocker was successfully updated!"
		else
			render 'edit'
		end

		#  new_params = mocker_params
		#  new_params = mocker_params.merge(active: true)
		
		#  if @mocker.update(new_params)
		#    flash[:notice] = "Genial! Esta guardado..."
		#  else
		#    flash[:alert] = "Uhm... Algo fallo."
		#  end
		#  redirect_to mock_path(@mock)
		#  redirect_back(fallback_location: request.referer)

	end



	private


	def set_mocker
    	@mocker = Mocker.friendly.find(params[:id])
	end

	def mocker_params
		params.require(:mocker).permit(:first_name, :last_name, :slug, :bio, :birthday)
	end


end
