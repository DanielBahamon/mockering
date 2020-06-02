class AddDataToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :first_name, :string
    add_column :mockers, :last_name, :string
    add_column :mockers, :bio, :text
  end
end
