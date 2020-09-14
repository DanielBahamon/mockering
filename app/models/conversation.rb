class Conversation < ApplicationRecord
	belongs_to :sender, foreign_key: :sender_id, class_name: "Mocker"
	belongs_to :recipient, foreign_key: :recipient_id, class_name: "Mocker"
	
    has_many :conversation_reports
	
	before_validation :set_uuid, on: :create

	has_many :messages, dependent: :destroy
	# validates_uniqueness_of :sender_id, :recipient_id

	scope :involving, -> (mocker) {
		where("conversations.sender_id = ? OR conversations.recipient_id = ?", mocker.id, mocker.id)
	}

	scope :between, -> (mocker_A, mocker_B) {
		where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", mocker_A, mocker_B, mocker_B, mocker_A)
	}


	def set_uuid
		self.id = SecureRandom.uuid
	end

end
