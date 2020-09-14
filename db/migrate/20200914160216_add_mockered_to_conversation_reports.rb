class AddMockeredToConversationReports < ActiveRecord::Migration[5.1]
  def change
    add_column :conversation_reports, :other_id, :string
  end
end
