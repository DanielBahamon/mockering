class AddSomethingsToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :original, :boolean
    add_column :mocks, :topicality, :boolean
    add_column :mocks, :research, :boolean
  end
end
