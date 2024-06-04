class Canvas < ApplicationRecord
  belongs_to :account
  before_create :canvas_upload
  before_update :canvas_upload
  attr_accessor :image_path

  def canvas_upload
    if image_path.present?
      key = "/canvases/#{self.aid}.png"
      self.original_key = key
      s3_upload(key: key, file: image_path, content_type: 'image/png')
      variants_key = "variants/original/canvases/#{self.aid}.png"
      s3_upload(key: variants_key, file: image_path, content_type: 'image/png')
    end
  end
  def image_url(variant_type: 'original')
    return object_url(key: "/variants/#{variant_type}/canvases/#{self.aid}.png")
  end
end
