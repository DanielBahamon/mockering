class AddDurationToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :duration, :string
  end
end
