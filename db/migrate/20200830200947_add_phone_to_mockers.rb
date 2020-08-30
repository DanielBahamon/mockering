class AddPhoneToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :phone_number, :string
    add_column :mockers, :pin, :string
    add_column :mockers, :phone_verified, :boolean
  end
end
