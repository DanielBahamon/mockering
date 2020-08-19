class AddChangetwoToMessages < ActiveRecord::Migration[5.1]
  def change
  	change_column :messages, :conversation_id, :string
  end
end
