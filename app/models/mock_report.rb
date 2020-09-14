class MockReport < ApplicationRecord
	belongs_to :mocker
	belongs_to :mock

	validates_uniqueness_of :mocker_id, scope: [:mock_id]

	enum classification: {
		Spam: 0,
		Copyright: 1,
		Obscene: 2,
		Violence: 3,
		Suicide: 4,
		"Self-injury": 5,
		Inappropriate: 6,
		Bullying: 7
	}
end
