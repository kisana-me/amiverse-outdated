class Item < ApplicationRecord
  include MeiliSearch::Rails
  meilisearch do
    attribute :content, :deleted, :created_at
    sortable_attributes [:deleted, :created_at]
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
  has_many :item_canvases
  has_many :canvases, through: :item_canvases
  # reply
  has_many :replied, class_name: 'Reply', foreign_key: 'replied_id'
  has_many :replier, class_name: 'Reply', foreign_key: 'replier_id'
  has_many :repliers, through: :replied, source: :replier
  has_many :replying, through: :replier, source: :replied
  # quote
  has_many :quoted, class_name: 'Quote', foreign_key: 'quoted_id'
  has_many :quoter, class_name: 'Quote', foreign_key: 'quoter_id'
  has_many :quoters, through: :quoted, source: :quoter
  has_many :quoting, through: :quoter, source: :quoted
  # reaction
  has_many :reactions
  has_many :emojis, through: :reactions
  # diffusion
  has_many :diffusions, foreign_key: 'diffused_id', class_name: 'Diffusion'
  has_many :diffused_accounts, through: :diffusions, source: :diffuser
  scope :with_diffused_at, -> {
    select('items.id, items.content, items.created_at AS timestamp, \'item\' AS type')
  }
  # validate
  validates :aid,
    presence: true,
    length: { is: 17, allow_blank: true },
    uniqueness: { case_sensitive: true } # 大文字小文字の違いを確認する
  # custom validate #
  validate :check_allowed_content
  before_create :associate_media
  # attr #
  attr_accessor :draft
  attr_accessor :selected_replied
  attr_accessor :selected_quoted
  attr_accessor :selected_images
  attr_accessor :selected_audios
  attr_accessor :selected_videos
  attr_accessor :selected_canvases
  # --- #

  private

  def associate_media
    if selected_images.present? # 画像
      selected_images.each do |aid|
        self.images << Image.find_by(aid: aid)
      end
    end
    # if params[:item][:selected_audios].present? # 音源
    #   params[:item][:selected_audios].each do |aid|
    #     @item.audios << Audio.find_by(aid: aid)
    #   end
    # end
    # if params[:item][:selected_videos].present? # 動画
    #   params[:item][:selected_videos].each do |aid|
    #     @item.videos << Video.find_by(aid: aid)
    #   end
    # end
    if selected_canvases.present? # キャンバス
      selected_canvases.each do |aid|
        self.canvases << Canvas.find_by(aid: aid)
      end
    end
  end

  def check_allowed_content
    if !(draft.to_i == 0) # modelで型定義ないからstrで来る
      errors.add(:draft, 'に対応していません')
    end
    if activitypub
      errors.add(:activitypub, 'に対応していません')
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
    if selected_audios.present?
      errors.add(:selected_audios, ':音源の設定に対応していません')
    end
    if selected_videos.present?
      errors.add(:selected_videos, ':動画の設定に対応していません')
    end
  end
end
