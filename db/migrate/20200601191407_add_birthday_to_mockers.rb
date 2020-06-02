class AddBirthdayToMockers < ActiveRecord::Migration[5.1]
  def change
	add_column :mockers, :birthday, :datetime
  end
end
