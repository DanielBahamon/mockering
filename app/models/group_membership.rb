class GroupMembership < ActiveRecord::Base
  groupify :group_membership
  before_validation :set_uuid, on: :create

  def set_uuid
    self.id = SecureRandom.uuid
  end
end
