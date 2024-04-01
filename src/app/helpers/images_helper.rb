module ImagesHelper
  def image_url(model: 'images', type: 'images', aid: '', format: '.webp')
    return object_url("variants/#{model}/#{type}/#{aid + format}")
  end
end