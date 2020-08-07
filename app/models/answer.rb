class Answer < ApplicationRecord
  belongs_to :mock
  belongs_to :mocker
  belongs_to :review
  acts_as_votable
end
