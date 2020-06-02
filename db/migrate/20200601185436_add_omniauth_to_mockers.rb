class AddOmniauthToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :provider, :string
    add_column :mockers, :uid, :string
  end
end
