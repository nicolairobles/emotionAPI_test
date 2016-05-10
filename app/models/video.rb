class Video < ActiveRecord::Base
	
	has_attached_file :video_file
	validates_attachment :video_file, content_type: { content_type: ["video/mp4", "video/mov", "video/avi", "video/wmv", "video/mpg", "video/webm"] }

end

#migration
# add_attachment :videos, :video_file