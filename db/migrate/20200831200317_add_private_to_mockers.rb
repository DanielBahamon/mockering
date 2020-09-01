class AddPrivateToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :privated, :boolean, default: false
  end
end
