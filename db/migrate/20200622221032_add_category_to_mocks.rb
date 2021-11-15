class AddCategoryToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :category, :integer
  end
end
