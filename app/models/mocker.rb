class Mocker < ApplicationRecord
 
	before_validation :set_uuid, on: :create

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :validatable, :confirmable,
	     :omniauthable, omniauth_providers: [:facebook, :google_oauth2]


    has_many :mocks

    has_many :active_friendships, class_name: "Friendship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_friendships, class_name: "Friendship", foreign_key: "followed_id", dependent: :destroy

    def follow(mocker)
    	active_friendships.create(followed_id: mocker.id)
    end
    def unfollow(mocker)
    	active_friendships.find_by(followed_id: mocker.id).destroy
    end

    def following?(mocker)
    	following.include?(mocker)
    end

    has_many :following, through: :active_friendships, source: :followed
    has_many :followers, through: :passive_friendships, source: :follower





  	acts_as_voter

	extend FriendlyId
	friendly_id :first_name, use: :slugged
	  
	validates :id, presence: true

	validates :slug, format: { without: /\s/, message: "must contain no spaces" }
  	validates :slug, format: { with: /\A[a-zA-Z0-9]+\Z/ }

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

	# AVATAR

	  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
	  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

	# avatar

end
