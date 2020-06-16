class AddAttachmentMusicToMocks < ActiveRecord::Migration[5.1]
  def self.up
    change_table :mocks do |t|
      t.attachment :music
    end
  end

  def self.down
    remove_attachment :mocks, :music
  end
end
