class ChangeMocktypeToIntegerInMocks < ActiveRecord::Migration[6.1]
  def change
    change_column :mocks, :mocktype, :integer
  end
end
