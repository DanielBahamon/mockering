class CreateMockerAppeals < ActiveRecord::Migration[5.1]
  def change
    create_table :mocker_appeals do |t|
    	t.string :mocker_id
    	t.string :reported_id
    	t.integer :reason
    	t.string :comment
      t.timestamps
    end
  end
end
