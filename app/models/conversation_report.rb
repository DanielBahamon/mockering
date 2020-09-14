class ConversationReport < ApplicationRecord
	belongs_to :mocker
	belongs_to :conversation

	validates_uniqueness_of :mocker_id, scope: [:conversation_id]

	enum classification: {
		Spam: 0,
		Obscene: 1,
		Violence: 2,
		Inappropriate: 3,
		Bullying: 4
	}
end
