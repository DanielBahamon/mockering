class AddChangeToGroups < ActiveRecord::Migration[5.1]
  def change
  	change_column :group_memberships, :member_id, :string
  	change_column :group_memberships, :group_id, :string
  end
end
