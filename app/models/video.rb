class Video < ActiveRecord::Base
	
	has_attached_file :video_file, styles: {
    :medium => {
      :geometry => "640x480",
      :format => 'mp4'
    },
    :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10}
  }, :processors => [:transcoder]
   
  validates_attachment_content_type :video_file, content_type: /\Avideo\/.*\Z/




	# has_attached_file :video_file
	# validates_attachment :video_file, content_type: { content_type: ["video/mp4", "video/mov", "video/avi", "video/wmv", "video/mpg", "video/webm"] }

end

#migration
# add_attachment :videos, :video_file