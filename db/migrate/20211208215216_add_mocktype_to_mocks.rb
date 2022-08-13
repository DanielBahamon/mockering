class AddMocktypeToMocks < ActiveRecord::Migration[6.1]
  def change
    add_column :mocks, :mocktype, :integer, default: 0
  end
end
