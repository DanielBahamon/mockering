class AddAdminToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :admin, :boolean, default: false
  end
end
