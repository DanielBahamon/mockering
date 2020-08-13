class Review < ApplicationRecord
  belongs_to :mock
  belongs_to :mocker
  has_many :answers
  acts_as_votable

end
