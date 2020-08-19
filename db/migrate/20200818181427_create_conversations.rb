class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations, id: false, force: true do |t|
      t.string :id, :limit => 36, :primary_key => true
      t.string :sender_id
      t.string :recipient_id

      t.timestamps
    end
  end
end
