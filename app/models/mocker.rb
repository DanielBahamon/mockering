class Mocker < ApplicationRecord
 
	before_validation :set_uuid, on: :create

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :validatable, :confirmable,
	     :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

	attr_writer :login

	def login
		@login || self.slug || self.email
	end

	validate :validate_slug

	def validate_slug
	  if Mocker.where(email: slug).exists?
	    errors.add(:slug, :invalid)
	  end
	end
	

	def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(slug) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:slug) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end

  	acts_as_voter
	extend FriendlyId
	friendly_id :first_name, use: :slugged
  	
	validates :id, presence: true

	validates :slug, format: { without: /\s/ , message: "must contain no spaces" }
  	validates :slug, :uniqueness => true
  	validates :phone_number, phone: true
  	# validates :slug, format: { with: /\A[a-zA-Z0-9]+\Z/ }

	def set_uuid
		self.id = SecureRandom.uuid
	end

	def self.from_omniauth(auth)
		mocker = Mocker.where(email: auth.info.email).first

		if mocker
		  return mocker
		else
		  where(provider: auth.provider, uid: auth.uid).first_or_create do |mocker|
		    mocker.email = auth.info.email
		    mocker.password = Devise.friendly_token[0,20]
		    mocker.first_name = auth.info.first_name || auth.info.profile   # assuming the user model has a name
		    mocker.last_name = auth.info.last_name || auth.info.profile  # assuming the user model has a name
		    mocker.image = auth.info.image # assuming the user model has an image
		    mocker.uid = auth.uid
		    mocker.provider = auth.provider
		    # If you are using confirmable and the provider(s) you use validate emails,
		    # uncomment the line below to skip the confirmation emails.
		    mocker.skip_confirmation!
		  end
		end
	end


    def follow(mocker)
    	active_friendships.create(followed_id: mocker.id)
    end
    def unfollow(mocker)
    	active_friendships.find_by(followed_id: mocker.id).destroy
    end

    def following?(mocker)
    	following.include?(mocker)
    end
    has_many :mocks
    has_many :messages, foreign_key: :conversation_id
    has_many :notifications, foreign_key: :recipient_id
    has_many :active_friendships, class_name: "Friendship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_friendships, class_name: "Friendship", foreign_key: "followed_id", dependent: :destroy
    has_many :following, through: :active_friendships, source: :followed
    has_many :followers, through: :passive_friendships, source: :follower
    has_many :mock_reports
  	has_one :setting
  	after_create :add_setting
  	

	  def add_setting
	    Setting.create(mocker: self, enable_sms: true, enable_email: true)
	  end

	# AVATAR

	has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "https://mockering.s3-sa-east-1.amazonaws.com/assets/avatar-placeholder.png"
	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

	# COVERPAGE

	has_attached_file :coverpage, styles: {extralarge: "1200x1200>", large: "999x999>", medium: "600x600>", thumb: "300x300>" }, default_url: "https://mockering.s3-sa-east-1.amazonaws.com/assets/bg_coverpage.jpg"
	validates_attachment_content_type :coverpage, content_type: /\Aimage\/.*\z/




	  def generate_pin
	    self.pin = SecureRandom.hex(2)
	    self.phone_verified = false
	    save
	  end

	  def send_pin
		account_sid = 'AC03ba4b2efd6622957cb2c00afe617013'
		auth_token = '84418e2903e8237fda5e62b32355fc33'
		client = Twilio::REST::Client.new(account_sid, auth_token)
		from = '+12058916654' # Your Twilio number
		client.messages.create(
			from: from,
			to: self.phone_number,
			body: "Hey! This is your pin: #{self.pin}"
		)
	  end
	  
	  def verify_pin(entered_pin)
	    update(phone_verified: true) if self.pin == entered_pin
	  end

end