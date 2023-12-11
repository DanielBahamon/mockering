class ChangeMocktypeToIntegerInMocksUsing < ActiveRecord::Migration[6.1]
  def up
    # SQLite no admite directamente el cambio de tipo de columna, así que usamos un enfoque diferente.
    change_column :mocks, :mocktype, :integer

    # Luego, eliminamos los valores no enteros de la columna si los hubiera.
    execute("UPDATE mocks SET mocktype = NULL WHERE NOT (mocktype = '' OR mocktype = '0' OR mocktype = '1');")
  end

  def down
    # Si necesitas revertir esta migración, simplemente cambia el tipo de columna a string.
    change_column :mocks, :mocktype, :integer
  end
end
