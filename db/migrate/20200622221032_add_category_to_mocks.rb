class AddCategoryToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :category, :string
  end
end
