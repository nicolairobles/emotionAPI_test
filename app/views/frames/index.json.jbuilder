json.array!(@frames) do |frame|
  json.extract! frame, :id, :video_id, :video_timestamp, :anger, :contempt, :disgust, :fear, :happiness, :neutral, :sadness, :surprise
  json.url frame_url(frame, format: :json)
end
