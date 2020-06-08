class AddSomechangesToVotes < ActiveRecord::Migration[5.1]
  def change
  	change_column :votes, :voter_id, :string
  	change_column :votes, :votable_id, :string
  end
end
