class AddChangeToTaggins < ActiveRecord::Migration[5.1]
  def change
  	change_column :taggings, :taggable_id, :string
  end
end
