class FriendshipsController < ApplicationController

	before_action :authenticate_mocker!
	before_action :find_mocker

	def create
		current_mocker.follow(@mocker)
		redirect_back fallback_location: root_path
	end
	def destroy
		current_mocker.unfollow(@mocker)
		redirect_back fallback_location: root_path
	end

	private

	def find_mocker
		@mocker = Mocker.find(params[:mocker_id])
	end
end