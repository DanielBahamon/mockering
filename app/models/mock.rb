class Mock < ApplicationRecord
	before_validation :set_uuid, on: :create
	belongs_to :mocker
  	acts_as_votable
	validates :id, presence: true

	is_impressionable
	is_impressionable counter_cache: true, column_name: :impressions_count, :unique => [:session_hash]
    acts_as_taggable_on :tags
	has_many :reviews
	has_many :answers
  	
	enum category: {
		Original: 0,
		Report: 1,
		Reaction: 2,
		Tutorial: 3
	}

	has_attached_file :picture, styles: {extralarge: "999x999>", large: "600x600>", medium: "300x300>", thumb: "150x150>" }, default_url: "https://mockering.s3-sa-east-1.amazonaws.com/assets/unnamed.jpg"
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

	# For music
	has_attached_file :music
	validates_attachment :music, 
	:content_type => {:content_type => ["audio/mpeg", "audio/mp3"]},
	:file_type => {:matches => [/mp3\Z/]}

	# For movie
	has_attached_file :movie, :styles => {
    	:medium => { :geometry => "640x480", :format => 'mp4' },
    	:thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
	 }, proccessors: [:transcoder]

	validates_attachment_content_type :movie, :content_type => /\Avideo\/.*\Z/
	# validates_presence_of :movie

	def set_uuid
		self.id = SecureRandom.uuid
	end

	def view_count_last_week
	    impressionist_count(:start_date => 1.week.ago)
	end


	after_create :add_mentions

	def add_mentions
		Mention.create_from_text(self)
	end

end
 