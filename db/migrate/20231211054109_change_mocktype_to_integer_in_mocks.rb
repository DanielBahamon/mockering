class ChangeMocktypeToIntegerInMocks < ActiveRecord::Migration[6.1]
  def up
    change_column :mocks, :mocktype, :integer
  end
  
  def down
    change_column :mocks, :mocktype, :integer # Cambia :integer a :string si el rollback es necesario
  end
end
