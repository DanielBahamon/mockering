class Mock < ApplicationRecord
	before_validation :set_uuid, on: :create
	validates :id, presence: true

	belongs_to :mocker
	
	has_attached_file :picture, styles: {large: "600x600>", medium: "300x300>", thumb: "150x150>" }
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

	def set_uuid
		self.id = SecureRandom.uuid
	end

end
