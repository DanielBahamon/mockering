class CreateConversationReports < ActiveRecord::Migration[5.1]
  def change
    create_table :conversation_reports do |t|
    	t.string :mocker_id
    	t.string :conversation_id
    	t.integer :classification
    	t.string :comment

      	t.timestamps
    end
  end
end
