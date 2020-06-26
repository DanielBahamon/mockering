class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.string :follower_id
      t.string :followed_id

      t.timestamps
    end

    add_index :friendships, :follower_id
    add_index :friendships, :followed_id
    add_index :friendships, [:follower_id, :followed_id], unique: true
  end
end
