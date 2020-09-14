class Block < ApplicationRecord 
	belongs_to :mocker

	validates_uniqueness_of :mocker_id, scope: [:blocked_id]

	enum reason: {
		Spam: 0,
		Obscene: 1,
		Violence: 2,
		Inappropriate: 3,
		Bullying: 4
	}
end
