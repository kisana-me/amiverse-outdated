class Video < ApplicationRecord
  enum render_type: { plane: 0, markdown: 1, html: 2, mfm: 3}
  enum visibility: { public_share: 0, do_not_share: 1, followers_share: 2, scopings_share: 3, direct_share: 4 }
  belongs_to :account
  has_many :item_videos
  has_many :items, through: :item_videos
  #has_one_attached :video
  #validates :video, attached: true,
  #  size: { less_than: 1000.megabytes },
  #  content_type: %w[ video/mp4 video/mpeg video/webm ]
  validate :video_type
  before_create :video_upload
  attr_accessor :video_data
  
  def video_upload(
    type: '',
    file: video_data.tempfile,
    extension: video_data.original_filename.split('.').last.downcase,
    content_type: self.video_data.content_type
  )
    case type
    when ''
      key = "/videos/#{aid}.#{extension}"
      #self.original_key = key
    else
      key = "/variants/videos/#{type}/#{aid}.#{extension}"
    end
    s3_upload(key: key, file: file, content_type: content_type)
  end

  def video_url
    type = "mp4"
    key = "/variants/videos/#{type}/#{self.aid}.#{type}"
    bucket_key = File.join(ENV["S3_BUCKET"], key)
    url = File.join(ENV["S3_PUBLIC_ENDPOINT"], bucket_key)
    return url
  end

  private
  def video_type
    unless video_data
      self.errors.add(:base, "画像がありません")
      return
    end
    allowed_content_types = ['video/mpeg', 'video/mp4', 'video/webm']
    unless allowed_content_types.include?(self.video_data.content_type)
      self.errors.add(:base, "未対応の形式です")
      return
    end
  end
end
