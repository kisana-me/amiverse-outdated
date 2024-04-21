module VideosHelper
  def video_url(model: 'videos', type: 'mp4', aid: '', format: '.mp4')
    return object_url("variants/#{model}/#{type}/#{aid + format}")
  end
end