class Mock < ApplicationRecord
	before_validation :set_uuid, on: :create
	belongs_to :mocker
  	acts_as_votable
	validates :id, presence: true

	is_impressionable

	has_many :reviews

	enum category: {
		Original: 0,
		Streaming: 1,
		Report: 2,
		Reaction: 3,
		Tutorial: 4
	}
	
	has_attached_file :picture, styles: {extralarge: "999x999>", large: "600x600>", medium: "300x300>", thumb: "150x150>" }, default_url: "https://mockering.s3-sa-east-1.amazonaws.com/assets/unnamed.jpg"
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

	# For music
	has_attached_file :music
	validates_attachment :music, 
	:content_type => {:content_type => ["audio/mpeg", "audio/mp3"]},
	:file_type => {:matches => [/mp3\Z/]}

	# For movie
	has_attached_file :movie, styles: {
		medium: {:geometry => "640x480", :format => 'jpg'}
		thumb: {:geometry => "100x100", :format => 'jpg', :time => 10}
	}, proccessors: [:transcoder]

	validates_attachment_content_type :movie,
    :content_type => [
      "video/mp4", 
      "video/quicktime",
      "video/3gpp",
      "video/x-ms-wmv", 
      "video/mov",
      "video/flv"
      ],
    :message => "Sorry! We do not accept the attached file type"
	after_post_process :save_image_dimensions

	def save_image_dimensions
	  geo = Paperclip::Geometry.from_file(movie.queued_for_write[:original])
	  self.image_width = geo.width
	  self.image_height = geo.height
	end

	# validates_attachment_content_type :movie, content_type: /\Avideo\/.*\z/, :content_type => ["video/mp4", "image/jpg"]

	def set_uuid
		self.id = SecureRandom.uuid
	end



end
 