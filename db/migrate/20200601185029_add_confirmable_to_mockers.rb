class AddConfirmableToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :image, :string

    add_column :mockers, :confirmation_token, :string
    add_column :mockers, :confirmed_at, :datetime
    add_column :mockers, :confirmation_sent_at, :datetime

    add_index :mockers, :confirmation_token, unique: true
  end
end
