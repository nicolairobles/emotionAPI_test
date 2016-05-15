class Frame < ActiveRecord::Base
  belongs_to :video

  default_value_for :video_timestamp do
    Time.now
  end
  
end
