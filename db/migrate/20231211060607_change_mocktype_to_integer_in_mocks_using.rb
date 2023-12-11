class ChangeMocktypeToIntegerInMocksUsing < ActiveRecord::Migration[6.1]
  def change
    change_column :mocks, :mocktype, 'integer USING CAST(mocktype AS integer)'
  end
end
