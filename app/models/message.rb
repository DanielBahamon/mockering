class Message < ApplicationRecord
  belongs_to :mocker
  belongs_to :conversation

  has_many :reports
  
  after_create_commit {
  	MessageBroadcastJob.perform_later(self)
  }

  after_create_commit :create_notification

  private
  	def create_notification
  		if self.conversation.sender_id == self.mocker_id
			sender = Mocker.find(self.conversation.sender_id)
			recipient = Mocker.find(self.conversation.recipient_id)
			Notification.create(recipient: recipient, actor: sender, action: "chated", notifiable: self.conversation)
		else
			sender = Mocker.find(self.conversation.sender_id)
			recipient = Mocker.find(self.conversation.recipient_id)
			Notification.create(recipient: sender, actor: recipient, action: "chated", notifiable: self.conversation)
  		end
  	end
end
