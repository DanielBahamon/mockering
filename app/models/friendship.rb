class Friendship < ApplicationRecord
	belongs_to :follower, class_name: "Mocker"
	belongs_to :followed, class_name: "Mocker"

	validates :follower_id, presence: true
	validates :followed_id, presence: true
end
