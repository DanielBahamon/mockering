class AddSomethingToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :show_mocks_privated, :boolean, default: false
  end
end
