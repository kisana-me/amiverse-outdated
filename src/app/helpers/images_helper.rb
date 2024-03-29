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
<<<<<<< HEAD
    return object_url("variants/images/#{image_path}")
=======
    return object_url(image_path)
>>>>>>> 91794735cdb4588bd2bb07b7c1c8e860cb9997cd
  end
end