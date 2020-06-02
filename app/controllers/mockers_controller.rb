class MockersController < ApplicationController
	before_action :authenticate_mocker!, except: [:show, :username_validator]

	def show
    	@mocker = Mocker.friendly.find(params[:id])
    	# @mocks = @mocker.mocks
	end

	def index
	end

	def mock_upload
		# @mocks = @mocker.mocks
	end

	def update
		new_params = mocker_params
		new_params = mocker_params.merge(active: true)

		if @room.update(new_params)
		  flash[:notice] = "Genial! Esta guardado..."
		else
		  flash[:alert] = "Uhm... Algo fallo."
		end

		# redirect_to mock_path(@mock)
		redirect_back(fallback_location: request.referer)

	end

	private

	def mocker_params
		params.require(:mocker).permit(:first_name, :last_name, :slug, :bio, :birthday)
	end
end
