class Answer < ApplicationRecord
	belongs_to :mock
	belongs_to :mocker
	belongs_to :review
	acts_as_votable

	after_create :add_mentions

	def add_mentions
		Mention.create_to_review(self)
	end

end
