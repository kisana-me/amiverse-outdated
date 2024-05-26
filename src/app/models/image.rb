class Image < ApplicationRecord
  enum render_type: { plane: 0, markdown: 1, html: 2, mfm: 3}
  enum visibility: { public_share: 0, do_not_share: 1, followers_share: 2, scopings_share: 3, direct_share: 4 }
  belongs_to :account
  has_many :item_images
  has_many :items, through: :item_images
  validate :image_type
  validate :check_storage_capacity
  before_create :upload_image
  before_destroy :delete_image
  attr_accessor :image_data
  include ObjectImage

  def upload_image
    key = image_upload(
      image_id: aid,
      file: image_data.tempfile,
      extension: image_data.original_filename.split('.').last.downcase,
      content_type: image_data.content_type
    )
    self.original_key = key
    self.data_size = image_data.size
    account.update(used_storage_size: account.used_storage_size += image_data.size)
  end
  def create_variant
    process_image(
      image_type: 'images',
      variant_type: 'images',
      image_id: aid,
      original_key: original_key,
      json_variants_array: self.variants
    )
    add_mca_data(self, 'variants', ['images'])
  end
  def delete_variants_image
    image_variants_delete(json_variants_array: variants, image_id: aid)
  end
  def delete_image
    image_delete(original_key: original_key, json_variants_array: variants, image_id: aid)
    account.update(used_storage_size: account.used_storage_size -= data_size)
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
    return unless image_data
    capacity = account.max_storage_size - account.used_storage_size
    if image_data.size > capacity
      errors.add(:image, "ストレージ容量がありません")
    end
  end
end
