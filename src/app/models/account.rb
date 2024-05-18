class Account < ApplicationRecord
  has_many :account_sessions
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
  include ObjectImage

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
    add_mca_data(self, 'roles', add_roles_array)
  end
  def remove_roles(remove_roles_array)
    remove_mca_data(self, 'roles', remove_roles_array)
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
