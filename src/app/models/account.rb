class Account < ApplicationRecord
  enum online_status: { online: 0, offline: 1, idle: 2, busy: 3 }
  enum online_visibility: { online_share: 0, online_personal: 1, online_followers: 2, online_scopings: 3, online_followers_scopings: 4 }
  enum birth_year_visibility: { birth_year_share: 0, birth_year_personal: 1, birth_year_followers: 2, birth_year_scopings: 3, birth_year_followers_scopings: 4 }
  enum birth_month_visibility: { birth_month_share: 0, birth_month_personal: 1, birth_month_followers: 2, birth_month_scopings: 3, birth_month_followers_scopings: 4 }
  enum birth_day_visibility: { birth_day_share: 0, birth_day_personal: 1, birth_day_followers: 2, birth_day_scopings: 3, birth_day_followers_scopings: 4 }
  enum followers_visibility: { followers_share: 0, followers_personal: 1, followers_followers: 2, followers_scopings: 3, followers_followers_scopings: 4 }
  enum following_visibility: { following_share: 0, following_personal: 1, following_followers: 2, following_scopings: 3, following_followers_scopings: 4 }
  enum reactions_visibility: { reactions_share: 0, reactions_personal: 1, reactions_followers: 2, reactions_scopings: 3, reactions_followers_scopings: 4 }
  enum usage_type: { personal: 0, bot: 1, commercial: 2 }
  enum status: { activated: 0, waiting: 1, doubt: 2, silenced: 3, locked: 4, hibernated: 5, suspended: 6, frozen: 7 }
  # 1:承認待ち 2:報告あがってるので確認まで一時停止 3:他人から極力見えないように 4:不審な行動を検出したので一時停止 5:自らアカウントを停止 6:当分利用停止 7:永久利用停止
  enum language: { japanese: 0, english: 1, korean: 2 }
  has_many :sessions
  has_many :clients, through: :sessions
  has_many :invitations
  has_many :items
  has_many :images
  has_many :videos
  has_many :emojis
  has_many :reactions
  has_many :messages
  has_many :notifications
  has_one_attached :icon
  has_one_attached :banner
  # follow
  has_many :followed, class_name: 'Follow', foreign_key: 'followed'
  has_many :follower, class_name: 'Follow', foreign_key: 'follower'
  has_many :followers, through: :followed, source: :follower
  has_many :following, through: :follower, source: :followed
  # varidate
  validates :icon,
    size: { less_than: 100.megabytes },
    content_type: %w[ image/jpeg image/png image/gif image/webp ]
  validates :banner,
    size: { less_than: 100.megabytes },
    content_type: %w[ image/jpeg image/png image/gif image/webp ]
  BASE_64_URL_REGEX  = /\A[a-zA-Z0-9_-]*\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :aid,
    presence: true,
    length: { in: 5..25, allow_blank: true },
    uniqueness: { case_sensitive: false }
  with_options unless: -> { validation_context == :skip } do
    validates :name_id,
      presence: true,
      length: { in: 5..50, allow_blank: true },
      format: { with: BASE_64_URL_REGEX, allow_blank: true },
      uniqueness: { case_sensitive: false }
    validates :email,
      length: { maximum: 255, allow_blank: true },
      format: { with: VALID_EMAIL_REGEX, allow_blank: true },
      uniqueness: { case_sensitive: false, allow_blank: true }
    validates :password,
      presence: true,
      length: { in: 8..63, allow_blank: true },
      allow_nil: true
    validate do |record|
      record.errors.add(:password, :blank) unless record.password_digest.present?
    end
    validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    validates_confirmation_of :password, allow_blank: true
  end
  has_secure_password validations: false
  attr_accessor :icon_data
  attr_accessor :banner_data
  validate :type_and_capacity
  before_create :upload_icon
  before_update :upload_icon

  def upload_icon
    Rails.logger.info('アップロード')
    return unless icon_data
    Rails.logger.info('アップロード開始')
    # icon_keyがあれば削除
    if icon_key.present?
      Rails.logger.info('画像あり＝＝＝＝＝＝＝＝＝＝＝＝')
    end
    key = image_upload(
      image_type: 'icon',
      image_id: aid,
      file: icon_data.tempfile,
      extension: icon_data.original_filename.split('.').last.downcase,
      content_type: icon_data.content_type
    )
    self.icon_key = key
    Rails.logger.info('画像あり＝＝＝＝＝＝＝＝＝＝＝＝')
    Rails.logger.info(icon_data.size)
    Rails.logger.info(used_storage_size)
    Rails.logger.info('画像あり＝＝＝＝＝＝＝＝＝＝＝＝')
    self.used_storage_size = used_storage_size.to_i + icon_data.size.to_i 
  end
  # other
  def add_roles(add_roles_array)
    add_array(object: self, column: 'roles', add_array: add_roles_array)
  end
  def remove_roles(remove_roles_array)
    remove_array(object: self, column: 'roles', add_array: remove_roles_array)
  end
  def administrator?
    #roles.include?('administrator')
    true
  end
  def moderator?
    roles.include?('moderator')
  end
  # --- #
  private
  def type_and_capacity
    Rails.logger.info('バリデーション')
    return unless icon_data
    Rails.logger.info('バリデーション開始')
    capacity = max_storage_size - used_storage_size
    if icon_data.size > capacity
      errors.add(:base, "ストレージ容量がありません")
    end
  end
  def valid_images
    if self.icon_key_changed?
      validate_using_image(self, icon_key, self.id)
    end
    if self.banner_key_changed?
      validate_using_image(self, banner_key, self.id)
    end
  end
end
