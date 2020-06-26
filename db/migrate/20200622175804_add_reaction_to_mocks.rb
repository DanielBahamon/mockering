class AddReactionToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :reaction, :boolean
    add_column :mocks, :urbanexploration, :boolean
  end
end
