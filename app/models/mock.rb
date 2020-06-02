class Mock < ApplicationRecord

	before_validation :set_uuid, on: :create
	validates :id, presence: true


	belongs_to :mocker
	

	def set_uuid
		self.id = SecureRandom.uuid
	end


end
