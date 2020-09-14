class AddReportedToConversations < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :reported, :boolean, default: false
  end
end
