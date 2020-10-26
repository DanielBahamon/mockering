class NotificationsController < ApplicationController
	before_action :authenticate_mocker!
	def index
		@notifications = Notification.where(recipient: current_mocker).unread
		@notifications_readed = Notification.where(recipient: current_mocker)
	end


	def mark_as_read
		@notifications = Notification.where(recipient: current_mocker).unread
		@notifications.update_all(read_at: Time.zone.now)

		render json: {success: true}
	end
end
