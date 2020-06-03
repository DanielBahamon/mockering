class AddAttachmentPictureToMocks < ActiveRecord::Migration[5.1]
  def self.up
    change_table :mocks do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :mocks, :picture
  end
end
