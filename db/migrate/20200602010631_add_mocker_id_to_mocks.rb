class AddMockerIdToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :mocker_id, :string
    add_index :mocks, :mocker_id
  end
end
