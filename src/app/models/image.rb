class Image < ApplicationRecord
  belongs_to :account
  has_many :item_images
  has_many :items, through: :item_images
  validate :image_type
  before_create :image_upload
  attr_accessor :image_data
  
  def image_upload(
    type: '',
    file: image_data.tempfile,
    extension: image_data.original_filename.split('.').last.downcase,
    content_type: self.image_data.content_type
  )
    case type
    when ''
      key = "/images/#{aid}.#{extension}"
      self.original_key = key
    else
      key = "/variants/images/#{type}/#{aid}.#{extension}"
    end
    s3_upload(key: key, file: file, content_type: content_type)
  end

  def image_delete
    s3 = Aws::S3::Client.new(
      endpoint: ENV["S3_ENDPOINT_0"],
      region: ENV["S3_REGION"],
      access_key_id: ENV["S3_USER"],
      secret_access_key: ENV["S3_PASSWORD"],
      force_path_style: true
    )
    #s3.get_object(bucket: bucket_name, key: 'file.txt')
    s3.delete_object(bucket: 'your-bucket-name', key: "#{aid}.#{'webp'}")
  end

  private
  def image_type
    unless image_data
      self.errors.add(:base, "画像がありません")
      return
    end
    allowed_content_types = ['image/png', 'image/jpeg', 'image/gif', 'image/webp']
    unless allowed_content_types.include?(self.image_data.content_type)
      self.errors.add(:base, "未対応の形式です")
      return
    end
  end
  def check_storage_capacity
    return unless image.attached?
    capacity = account.storage_max_size - account.storage_size
    if image.blob.byte_size > capacity
      errors.add(:image, "ストレージ容量が足りません")
    end
  end
end
