class AddBadgeToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :verification, :string
  end
end
