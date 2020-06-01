class CreateMocks < ActiveRecord::Migration[5.1]
  def change
    create_table :mocks, id: false, force: true do |t|
      t.string :id, limit: 36, primary_key: true, null: false 
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
