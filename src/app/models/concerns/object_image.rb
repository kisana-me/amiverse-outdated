module ObjectImage
  def image_upload(
    image_type: 'images',
    variant_type: '',
    image_id:,
    extension: 'webp',
    content_type: 'image/webp',
    file:
  )
    case variant_type
    when ''
      key = "/originals/#{image_type}/#{image_id}.#{extension}"
    else
      key = "/variants/#{variant_type}/#{image_type}/#{image_id}.#{extension}"
    end
    s3_upload(key: key, file: file, content_type: content_type)
    return key
  end

  def image_variants_delete(image_type: 'images', json_variants_array:, image_id:)
    JSON.parse(json_variants_array).each do |variant|
      key = "/variants/#{variant}/#{image_type}/#{image_id}.webp"
      s3_delete(key: key)
    end
  end

  def image_delete(image_type: 'images', original_key:, json_variants_array:, image_id:)
    image_variants_delete(image_type: image_type, json_variants_array: json_variants_array, image_id: image_id)
    s3_delete(key: original_key)
  end

  def process_image(
    image_type: 'images',
    variant_type: 'images',
    image_id:,
    original_key:,
    json_variants_array:
  )
    variants =JSON.parse(json_variants_array)
    if variants.include?(variant_type)
      return
    end
    s3 = Aws::S3::Client.new(
      endpoint: ENV["S3_LOCAL_ENDPOINT"],
      region: ENV["S3_REGION"],
      access_key_id: ENV["S3_USER"],
      secret_access_key: ENV["S3_PASSWORD"],
      force_path_style: true
    )
    downloaded_image = Tempfile.new(['downloaded_image'])
    converted_image = Tempfile.new(['converted_image'])
    s3.get_object(bucket: ENV["S3_BUCKET"], key: original_key, response_target: downloaded_image.path)
    image = MiniMagick::Image.open(downloaded_image.path)
    resize = "2000x2000>"
    extent = "" # 切り取る
    case variant_type
    # icon
    when 'icons'
      resize = "500x500^"
      extent = "500x500"
    when 'tb-icons'
      resize = "100x100^"
      extent = "100x100"
    # banner
    when 'banners'
      resize = "1600x1600^"
      extent = "1600x1600"
    when 'tb-banners'
      resize = "400x400^"
      extent = "400x400"
    # image
    when 'images'
      resize = "2000x2000>"
    when 'tb-images'
      resize = "700x700>"
    when '4k-images'
      resize = "4000x4000>"
    # emoji
    when 'emojis'
      resize = "500x500>"
    when 'tb-emojis'
      resize = "200x200>"
    end
    image.format('webp')
    image.coalesce
    image.combine_options do |img|
      img.gravity "center"
      img.quality 85
      img.auto_orient
      img.strip # EXIF削除
      img.resize resize
      unless extent == ''
        img.extent extent
      end
    end
    image.write(converted_image.path)
    image_upload(
      image_type: image_type,
      variant_type: variant_type,
      image_id: image_id,
      file: converted_image.path
    )
    downloaded_image.close
    converted_image.close
  end
end