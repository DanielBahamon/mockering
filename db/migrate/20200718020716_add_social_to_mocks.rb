class AddSocialToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :facebook, :string
    add_column :mockers, :twitter, :string
    add_column :mockers, :linkedin, :string
    add_column :mockers, :instagram, :string
    add_column :mockers, :pinterest, :string
  end
end
