class AddChangeToNotifications < ActiveRecord::Migration[5.1]
  def change
  	change_column :notifications, :notifiable_id, :string
  end
end
