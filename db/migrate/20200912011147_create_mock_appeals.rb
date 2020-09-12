class CreateMockAppeals < ActiveRecord::Migration[5.1]
  def change
    create_table :mock_appeals do |t|
    	t.string :mocker_id
    	t.string :mock_id
    	t.integer :reason
    	t.string :comment
      t.timestamps
    end
  end
end
