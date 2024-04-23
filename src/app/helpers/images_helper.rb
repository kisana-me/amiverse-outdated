module ImagesHelper
  def image_url(variant_type: 'images', image_type: 'images', id: '', extension: 'webp', key: '')
    if key.blank?
      if image_type == ''
        key = "original/#{image_type}/#{id}.#{extension}"
      else
        key = "variants/#{variant_type}/#{image_type}/#{id}.#{extension}"
      end
    end
    return object_url(key)
  end
end