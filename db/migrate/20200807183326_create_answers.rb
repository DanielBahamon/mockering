class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :comment
      t.string :mock_id
      t.string :mocker_id
      t.integer :review_id

      t.timestamps
    end
  end
end
