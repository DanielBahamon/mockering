class CreateMockerReports < ActiveRecord::Migration[5.1]
  def change
    create_table :mocker_reports do |t|
    	t.string :mocker_id
    	t.string :reported_id 
    	t.integer :classification
    	t.string :comment
      t.timestamps
    end
  end
end
