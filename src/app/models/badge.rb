class Badge < ApplicationRecord
  has_many :account_badge
  has_many :accounts, through: :account_badge

  validate :image_type_and_required
  before_create :image_upload
  before_update :image_upload
  attr_accessor :image

  def image_upload
    if image
      if self.original_key.present?
        delete_variants(image_type: 'badges')
        s3_delete(key: self.original_key)
      end
        extension = image.original_filename.split('.').last.downcase
        key = "/badges/#{self.aid}.#{extension}"
        self.original_key = key
        s3_upload(key: key, file: self.image.path, content_type: self.image.content_type)
    end
  end
  def image_url(variant_type: 'badges')
    if self.original_key.present?
      unless self.variants.include?(variant_type)
        process_image(variant_type: variant_type, image_type: 'badges')
      end
      return object_url(key: "/variants/#{variant_type}/badges/#{self.aid}.webp")
    else
      return nil
    end
  end
  def variants_delete
    delete_variants(image_type: 'badges')
  end
  def image_delete
    delete_image()
  end

  private

  def image_type_and_required
    varidate_image(required: false)
  end
end