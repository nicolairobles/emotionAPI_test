class AddAttachmentVideoFileToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :video_file
    end
  end

  def self.down
    remove_attachment :videos, :video_file
  end
end
