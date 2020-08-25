class GroupifyMigration < ActiveRecord::Migration[5.1]
  def change
    create_table :groups, id: false, force: true do |t|
      t.string :id, :limit => 36, :primary_key => true
      t.string     :type

      t.timestamps
    end

    create_table :group_memberships, id: false, force: true do |t|
      t.string :id, :limit => 36, :primary_key => true
      t.references :member, polymorphic: true, index: true, null: false
      t.references :group, polymorphic: true, index: true

      # The named group to which a member belongs (if using)
      t.string     :group_name, index: true

      # The membership type the member belongs with
      t.string     :membership_type

      t.timestamps
    end
  end
end
