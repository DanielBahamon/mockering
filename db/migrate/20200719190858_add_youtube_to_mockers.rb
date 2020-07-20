class AddYoutubeToMockers < ActiveRecord::Migration[5.1]
  def change
    add_column :mockers, :youtube, :string
  end
end
