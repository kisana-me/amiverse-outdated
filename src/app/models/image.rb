class Image < ApplicationRecord
  enum render_type: { plane: 0, markdown: 1, html: 2, mfm: 3}
  enum visibility: { visibility_public_share: 0, visibility_do_not_share: 1, visibility_followers_share: 2, visibility_groups_share: 3, visibility_direct_share: 4 }
  enum limitation: { limitation_public_share: 0, limitation_do_not_share: 1, limitation_followers_share: 2, limitation_groups_share: 3, limitation_direct_share: 4 }
  belongs_to :account
  has_many :item_images
  has_many :items, through: :item_images

  validate :image_type_and_required
  before_create :image_upload
  before_update :image_upload
  attr_accessor :image

  def image_upload
    if image
      if self.original_key.present?
        delete_variants()
        s3_delete(key: self.original_key)
      end
        extension = image.original_filename.split('.').last.downcase
        key = "/images/#{self.aid}.#{extension}"
        self.original_key = key
        s3_upload(key: key, file: self.image.path, content_type: self.image.content_type)
    end
  end
  def image_url(variant_type: 'images')
    if self.original_key.present?
      unless self.variants.include?(variant_type)
        process_image(variant_type: variant_type)
      end
      return object_url(key: "/variants/#{variant_type}/images/#{self.aid}.webp")
    else
      return '/'
    end
  end
  def variants_delete
    delete_variants()
  end
  def image_delete
    delete_image()
  end

  private

  def image_type_and_required
    varidate_image()
  end
end
