class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.string :mock_id
      t.string :mocker_id

      t.timestamps
    end
  end
end
