class FriendshipsController < ApplicationController
	before_action :authenticate_mocker!
	before_action :find_mocker


	def index 
	end

	def show
		@friendship = Friendship.find(params[:id])
		respond_to do |format|
			format.html { @friendship }
			format.js
		end
	end
	def create
		current_mocker.follow(@mocker)
		Notification.create(recipient: @mocker, actor: current_mocker, action: "followed", notifiable: current_mocker)
		# redirect_back fallback_location: root_path
	    redirect_to root_url
	end
	def destroy
		current_mocker.unfollow(@mocker)
		# redirect_back fallback_location: root_path
	    redirect_to root_url

	end

	private
	
		def find_mocker
			@mocker = Mocker.find(params[:mocker_id])
		end
end