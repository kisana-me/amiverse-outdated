module ImagesHelper
  def image_url(image_aid, type = 'images', format = '.webp')
    case type
    when 'icon'
      type = 'icons'
    when 'banner'
      type = 'banners'
    else
      type = 'images'
    end
    image_path = File.join(type, image_aid + format)
    return object_url(image_path)
  end
end