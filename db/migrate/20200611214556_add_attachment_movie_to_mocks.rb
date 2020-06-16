class AddAttachmentMovieToMocks < ActiveRecord::Migration[5.1]
  def self.up
    change_table :mocks do |t|
      t.attachment :movie
    end
  end

  def self.down
    remove_attachment :mocks, :movie
  end
end
