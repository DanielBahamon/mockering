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
	has_many :mock_reports
	has_many :mock_appeals

  	
	enum category: {
		Whatever: 0,
		Knowledge: 1,
		Paranormal: 2,
		Short: 3,
		Aliens: 4,
		Animation: 5,
		Videoclip: 6,
		Podcast: 7,
		Reaction: 8,
		"Social justice": 9,
		Health: 10,
		History: 11,
		Tutorial: 12,
		"Physical training": 13,
		Tribute: 14,
		Report: 15,
		Music: 16,
		Nature: 17
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
    	:thumb => { :geometry => "300x300#", :format => 'jpg', :time => 10 }
	 }, proccessors: [:transcoder]

	validates_attachment_content_type :movie, :content_type => /\Avideo\/.*\Z/
	# validates_presence_of :movie
	#before_post_process :movie? do
	#	video_attributes = RVideo::Inspector.new(:file => self.movie.path)
	#	self.duration = video_attributes.duration # duration in milliseconds
	  #file = movie.queued_for_write[:original].path
	  # file =  FFMPEG::Movie.new("#{self.movie.path}", FFMPEG.ffmpeg_binary = '/usr/local/bin/ffmpeg')
	  #movi = FFMPEG::Movie.new(movie.queued_for_write[:original].path)
	  # self.duration = Paperclip.run("ffprobe", '-i %s -show_entries format=duration -v quiet -of csv="p=0"' % file).to_f
	  # result = 'ffmpeg -i #{self.movie.path} 2 > & 1'
	  # r = result.match("Duration: ([0-9]+):([0-9]+):([0-9]+).([0-9]+)")
	  #self.duration = file[1].to_i * 3600 + file[2].to_i * 60 + file[3].to_i
	  # self.duration = file.duration
	#end


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
 