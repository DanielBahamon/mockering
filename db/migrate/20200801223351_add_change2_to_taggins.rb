class AddChange2ToTaggins < ActiveRecord::Migration[5.1]
  def change
  	change_column :taggings, :tagger_id, :string
  end
end
