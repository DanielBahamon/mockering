class MockReport < ApplicationRecord
	belongs_to :mocker
	belongs_to :mock
	# validates_uniqueness_of :mocker_id, :mock_id
	validates_uniqueness_of :mocker_id, scope: [:mock_id]

	enum classification: {
		Copyright: 0,
		Obscene: 1,
		Violence: 2,
		Suicide: 3,
		"Self-injury": 4,
		Inappropriate: 5
	}
end
