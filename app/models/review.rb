class Review < ApplicationRecord
  belongs_to :mock
  belongs_to :mocker
  acts_as_votable
end
