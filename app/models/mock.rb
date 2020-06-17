class Mock < ApplicationRecord
	before_validation :set_uuid, on: :create
	belongs_to :mocker
  	acts_as_votable
	validates :id, presence: true
	
	has_attached_file :picture, styles: {extralarge: "999x999>", large: "600x600>", medium: "300x300>", thumb: "150x150>" }
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

	# For music
	has_attached_file :music
	validates_attachment :music, 
	:content_type => {:content_type => ["audio/mpeg", "audio/mp3"]},
	:file_type => {:matches => [/mp3\Z/]}

	# For movie
	has_attached_file :movie, :styles =>
	{
		:medium => {:geometry => "640x480", :format => 'mp4'},
		:thumb => {:geometry => "100x50", :format => 'jpg', :time => 10}
	}, :proccessor => [:transcoder]
	validates_attachment_content_type :movie, content_type: /\Avideo\/.*\z/
	
	def set_uuid
		self.id = SecureRandom.uuid
	end

end
 