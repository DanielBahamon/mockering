class AddPhotoToMockers < ActiveRecord::Migration[5.1]
  def up
    change_table :mockers do |t|
      t.attachment :photo
    end
  end

  def down
    remove_attachment :mockers, :photo
  end
end
