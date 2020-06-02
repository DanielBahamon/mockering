class AddSlugToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :slug, :string
    add_index :mockers, :slug, unique: true
  end
end
