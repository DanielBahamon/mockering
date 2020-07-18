class AddAttachmentCoverpageToMockers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :mockers do |t|
      t.attachment :coverpage
    end
  end

  def self.down
    remove_attachment :mockers, :coverpage
  end
end
