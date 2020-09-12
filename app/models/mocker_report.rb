class MockerReport < ApplicationRecord
	belongs_to :mocker
	validates_uniqueness_of :mocker_id, scope: [:reported_id]

	enum classification: {
		Copyright: 0,
		Obscene: 1,
		Violence: 2,
		Suicide: 3,
		"Self-injury": 4,
		Inappropriate: 5,
		Bullying: 6
	}
end
