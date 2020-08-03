class AddSomethingsToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :impressions_count, :integer, default: 0
  end
end
