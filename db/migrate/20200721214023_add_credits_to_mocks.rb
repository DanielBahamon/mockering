class AddCreditsToMocks < ActiveRecord::Migration[5.1]
  def change
    add_column :mocks, :credits, :string
  end
end
