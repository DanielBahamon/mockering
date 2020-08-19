class AddChangeToMessages < ActiveRecord::Migration[5.1]
  def change
  	change_column :messages, :mocker_id, :string
  end
end
