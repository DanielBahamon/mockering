class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.string :mocker_id
      t.string :conversation_id

      t.timestamps
    end
  end
end
