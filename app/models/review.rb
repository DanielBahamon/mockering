class Review < ApplicationRecord
  belongs_to :mock
  belongs_to :mocker
  has_many :answers
  acts_as_votable




	after_create :add_mentions

	def add_mentions
		Mention.create_to_review(self)
	end

end
