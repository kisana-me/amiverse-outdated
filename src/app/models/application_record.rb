class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def process_image(type: 'images')
    variants =JSON.parse(self.variants)
    Rails.logger.info(self.variants)
    if variants.include?(type)
      Rails.logger.info('処理済み')
      return
    else
      Rails.logger.info('含まれず')
    end
    Rails.logger.info('処理開始')
    s3 = Aws::S3::Client.new(
      endpoint: ENV["S3_ENDPOINT_0"],
      region: ENV["S3_REGION"],
      access_key_id: ENV["S3_USER"],
      secret_access_key: ENV["S3_PASSWORD"],
      force_path_style: true
    )
    temp_file = Tempfile.new(['image', '.img'])
    s3.get_object(bucket: ENV["S3_BUCKET"], key: self.original_key, response_target: temp_file.path)
    Rails.logger.info(temp_file.path)
    image = MiniMagick::Image.read(temp_file)
    converted_image = MiniMagick::Tool::Convert.new
    converted_image << image.path
    converted_image.format("webp")
    resize = "2048x2048>"
    extent = "" # 切り取る
    case type
    # icon
    when 'icons'
      resize = "400x400^"
      extent = "400x400"
    when 'tb-icons'
      resize = "50x50^"
      extent = "50x50"
    # banner
    when 'banners'
      resize = "1600x1600^"
      extent = "1600x1600"
    when 'tb-banners'
      resize = "400x400^"
      extent = "400x400"
    # image
    when 'images'
      resize = "2048x2048>"
    when 'tb-images'
      resize = "700x700>"
    when '4k-images'
      resize = "4096x4096>"
    # emoji
    when 'emojis'
      resize = "200x200>"
    when 'tb-emojis'
      resize = "50x50>"
    end
    converted_image.combine_options do |img|
      img.gravity "center"
      img.quality 85
      img.auto_orient
      img.format "webp"
      img.strip # EXIF削除
      img.resize resize
      img.extent extent
    end
    converted_image.write(temp_file)
    #ok
    Rails.logger.info('処理終了')
    image_upload(
      type: type,
      file: temp_file,
      extension: 'webp',
      content_type: 'image/webp'
    )
    add_mca_data(self, 'variants', [type])
    Rails.logger.info('アップロード完了')
  end
  private
  def validate_using_image(ins, image_aid, account_id = 0)
    if image_aid.present?
      if image = Image.find_by(
        aid: image_aid,
        deleted: false
      )
        unless account_id == image.account_id
          if image.private || JSON.parse(image.permission_scope).all? { |item| item.is_a?(Hash) && !item['icon'].nil? }   
            ins.errors.add(:base, '画像の所有者は使用を許可していません')
          end
        end
      else
        ins.errors.add(:base, '画像が存在しません')
      end
    end
  end
  def add_mca_data(object, column, add_mca_array)
    mca_array = JSON.parse(object[column.to_sym])
    add_mca_array.each do |role|
      mca_array.push(role)
    end
    object.update(column.to_sym => mca_array.to_json)
  end
  def remove_mca_data(object, column, remove_mca_array)
    mca_array = JSON.parse(object[column.to_sym])
    remove_mca_array.each do |role|
      mca_array.delete(role)
    end
    object.update(column.to_sym => mca_array.to_json)
  end
  def s3_upload(key:, file:, content_type:)
    s3 = Aws::S3::Resource.new(
      endpoint: ENV["S3_ENDPOINT_0"],
      region: ENV["S3_REGION"],
      access_key_id: ENV["S3_USER"],
      secret_access_key: ENV["S3_PASSWORD"],
      force_path_style: true
    )
    obj = s3.bucket(ENV["S3_BUCKET"]).object(key)
    obj.upload_file(file, content_type: content_type)
  end
end
