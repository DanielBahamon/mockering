class MocksController < ApplicationController
	
	before_action :find_mock, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :like, :dislike]
	before_action :is_admin!, except: [:index, :like, :dislike, :show, :upvote, :downvote, :destroy, :create, :edit, :new]
	before_action :authenticate_mocker!, only: [:like, :dislike, :upvote, :downvote]
	
	def index
		# @mocks = Mock.all.order("created_at DESC")
  		@q = Mock.ransack(params[:q])
		@mocks = @q.result(distinct: true).order("created_at DESC")
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

	def like
		if current_mocker.voted_for? @mock
			@mock.unliked_by current_mocker
		else
			@mock.liked_by current_mocker
		end
	end

	def dislike
		if current_mocker.voted_for? @mock
			@mock.unliked_by current_mocker
		else
			@mock.downvote_from current_mocker
		end
	end

	def upvote
		@mock.upvote_from current_mocker
		redirect_back fallback_location: root_path
	end

	def downvote
		@mock.downvote_from current_mocker
		redirect_back fallback_location: root_path
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

	def find_mock
		@mock = Mock.find(params[:id])
	end

	def mock_params
		params.require(:mock).permit(:title, :description, :picture, :music, :movie)
	end

end
