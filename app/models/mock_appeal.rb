class MockAppeal < ApplicationRecord
	belongs_to :mocker
	belongs_to :mock
	

	validates_uniqueness_of :mocker_id, scope: [:mock_id]
	
	enum reason: {
		"Freedom Expression": 0,
		Incriminate: 1,
		"Political persecution": 2,
		Other: 3
	}
end
