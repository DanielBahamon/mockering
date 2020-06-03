class MocksController < ApplicationController

	before_action :find_mock, only: [:show, :edit, :update, :destroy]
	before_action :is_authorised, only: [:edit, :update, :destroy, :update, :to_slug]
	def index
		@mocks = Mock.all.order("created_at DESC")
	end

	def new
		@mock = current_mocker.mocks.build
	end

	def create
		@mock = current_mocker.mocks.build(mock_params)

		if @mock.save
			redirect_to @mock, notice: "Successfully created new Mock"
		else
			render 'new'
		end
	end

	def show
	end

	def edit
		
	end
	
	def update
		if @mock.update(mock_params)
			redirect_to @mock, notice: "Mock was successfully updated!"
		else
			render 'edit'
		end
	end

	def destroy
		@mock.destroy
		redirect_to root_path
	end


	private

	def mock_params
		params.require(:mock).permit(:title, :description, :picture)
	end

	def find_mock
		@mock = Mock.find(params[:id])
	end

    def is_authorised
      redirect_to root_path, alert: "No tienes permiso" unless current_mocker.id == @mock.mocker_id
    end
end
