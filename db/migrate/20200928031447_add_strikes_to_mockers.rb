class AddStrikesToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :strikes, :integer, default: 0
  end
end
