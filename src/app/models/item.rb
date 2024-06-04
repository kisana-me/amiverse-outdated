class Item < ApplicationRecord
  include MeiliSearch::Rails
  meilisearch do
    attribute :content
    # displayed_attributes [:user_id, :created_at]
  end
  enum render_type: { plane: 0, markdown: 1, html: 2, mfm: 3}
  enum layout_type: { text: 0, image: 1, audio: 2, video: 3}
  enum visibility: { public_share: 0, do_not_share: 1, followers_share: 2, scopings_share: 3, direct_share: 4 }
  enum usage_type: { personal: 0, bot: 1, commercial: 2 }
  enum status: { shared: 0, waiting: 1, doubt: 2, reported: 3, suspended: 4, violated: 5 }
  enum language: { japanese: 0, english: 1, korean: 2 }
  belongs_to :account
  has_many :item_images
  has_many :images, through: :item_images
  has_many :item_audios
  has_many :audios, through: :item_audios
  has_many :item_videos
  has_many :videos, through: :item_videos
  # reply
  has_many :replied, class_name: 'Reply', foreign_key: 'replied'
  has_many :replier, class_name: 'Reply', foreign_key: 'replier'
  has_many :repliers, through: :replied, source: :replier
  has_many :replying, through: :replier, source: :replied
  # quote
  has_many :quoted, class_name: 'Quote', foreign_key: 'quoted'
  has_many :quoter, class_name: 'Quote', foreign_key: 'quoter'
  has_many :quoters, through: :quoted, source: :quoter
  has_many :quoting, through: :quoter, source: :quoted
  # reaction
  has_many :reactions
  has_many :emojis, through: :reactions
  # validate
  validates :aid,
    presence: true,
    length: { is: 17, allow_blank: true },
    uniqueness: { case_sensitive: true } # 大文字小文字の違いを確認する
  # custom validate #
  validate :check_allowed_content
  # attr #
  attr_accessor :draft
  attr_accessor :selected_replied
  attr_accessor :selected_quoted
  attr_accessor :selected_images
  attr_accessor :selected_audios
  attr_accessor :selected_videos
  attr_accessor :media
  # --- #

  private

  def check_allowed_content
    if activitypub
      errors.add(:activitypub, 'に対応していません')
    end
    if draft == 1
      errors.add(:draft, 'に対応していません')
    end
    if silent
      errors.add(:silent, 'に対応していません')
    end
    if !text?
      errors.add(:layout_type, ':text以外に対応していません')
    end
    if !plane?
      errors.add(:render_type, ':plane以外に対応していません')
    end
    if !japanese?
      errors.add(:language, ':japanese以外に対応していません')
    end
    if !personal?
      errors.add(:usage_type, ':personal以外に対応していません')
    end
    if media.present?
      errors.add(:media, ':に対応していません')
    end
    if selected_images.present?
      errors.add(:selected_images, ':iの設定に対応していません')
    end
    if selected_audios.present?
      errors.add(:selected_audios, ':音源の設定に対応していません')
    end
    if selected_videos.present?
      errors.add(:selected_videos, ':動画の設定に対応していません')
    end
  end
end
