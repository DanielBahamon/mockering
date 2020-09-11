class CreateMockReports < ActiveRecord::Migration[5.1]
  def change
    create_table :mock_reports do |t|
    	t.string :mocker_id
    	t.string :mock_id 
    	t.integer :classification
    	t.string :comment
      t.timestamps
    end
  end
end
