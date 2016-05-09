json.array!(@videos) do |video|
  json.extract! video, :id, :time_length
  json.url video_url(video, format: :json)
end
