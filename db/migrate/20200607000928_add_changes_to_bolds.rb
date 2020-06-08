class AddChangesToBolds < ActiveRecord::Migration[5.1]
  def change
  	change_column :bolds, :voter_id, :string
  	change_column :bolds, :votable_id, :string
  end
end
