class MockerAppeal < ApplicationRecord
	belongs_to :mocker	

	validates_uniqueness_of :mocker_id, scope: [:reported_id]
	enum reason: {
		"Freedom Expression": 0,
		Incriminate: 1,
		"Political persecution": 2,
		Other: 3
	}
end
