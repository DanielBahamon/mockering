class Mocker < ApplicationRecord
 
	before_validation :set_uuid, on: :create

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :validatable, :confirmable,
	     :omniauthable, omniauth_providers: [:facebook, :google_oauth2]


    has_many :mocks

  	acts_as_voter

	extend FriendlyId
	friendly_id :full_name, use: :slugged

	  def full_name
	    "#{first_name} #{last_name}"
	  end
	  
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


end
