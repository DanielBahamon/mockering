class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
    	t.string :mocker_id
    	t.string :blocked_id
    	t.integer :reason
    	t.boolean :status, default: true
      t.timestamps
    end
  end
end
