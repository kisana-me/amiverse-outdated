module ImageTools

  private

  def process_image(variant_type: 'images', image_type: 'images', variants_column: 'variants', original_key_column: 'original_key')
    variants =JSON.parse(self.send(variants_column))
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
    s3.get_object(bucket: ENV["S3_BUCKET"], key: self.send(original_key_column), response_target: downloaded_image.path)
    resize = "2048x2048>" # max2048
    extent = "" # 切り取る
    case variant_type
    when 'icons' # fit200
      resize = "200x200^"
      extent = "200x200"
    when 'banners' # fit400x200
      resize = "400x200^"
      extent = "400x200"
    when 'images' # max2048
      resize = "2048x2048>"
    when 'lite-images' # max720
      resize = "720x720>"
    when '4k-images' # max4096
      resize = "4096x4096>"
    when 'emojis' # max300x200
      resize = "300x200>"
    when 'badges' # fit100
      resize = "100x100^"
      extent = "100x100"
    end
    image = MiniMagick::Image.open(downloaded_image.path)
    if image.frames.count > 1
      processed = ImageProcessing::MiniMagick
        .source(downloaded_image.path)
        .loader(page: nil)
        .coalesce
        .gravity("center")
        .resize(resize)
        .then do |chain|
          if extent.present?
            chain.extent(extent)
          else
            chain
          end
        end
        .strip
        .auto_orient
        .quality(85)
        .convert("webp")
        .call(destination: converted_image.path)
    else
      image = MiniMagick::Image.open(downloaded_image.path)
      image.format('webp')
      image = image.coalesce
      image.combine_options do |img|
        img.gravity "center"
        img.quality 85
        #img.auto_orient
        img.strip # EXIF削除
        img.resize resize
        unless extent == ''
          img.extent extent
        end
      end
      image.write(converted_image.path)
    end
    key = "/variants/#{variant_type}/#{image_type}/#{self.aid}.webp"
    s3_upload(key: key, file: converted_image.path, content_type: 'image/webp')
    add_array(object: self, column: variants_column, add_array: [variant_type], save: true)
    downloaded_image.close
    converted_image.close
  end

  def delete_variants(variants_column: 'variants', image_type: 'images')
    arr = JSON.parse(self.send(variants_column))
    arr.each do |variant_type|
      s3_delete(key: "/variants/#{variant_type}/#{image_type}/#{self.aid}.webp")
    end
    remove_array(object: self, column: variants_column, remove_array: arr, save: false)
  end

  def delete_image(original_key_column: 'original_key', variants_column: 'variants', image_type: 'images')
    delete_variants(variants_column: variants_column, image_type: image_type)
    s3_delete(key: self.send(original_key_column))
    self.update(original_key_column.to_sym => '')
  end

  def varidate_image(column_name: 'image', required: true)
    file = self.send(column_name)
    if file
      begin
        image = MiniMagick::Image.read(file)
        allowed_content_types = ['image/png', 'image/jpeg', 'image/gif', 'image/webp']
        unless allowed_content_types.include?(image.mime_type)
          errors.add(column_name.to_sym, "未対応の形式です")
        end
      rescue MiniMagick::Invalid
        errors.add(column_name.to_sym, "無効な画像ファイルです")
      end
    elsif self.new_record? && required
      errors.add(column_name.to_sym, "画像がありません")
    end
  end
end