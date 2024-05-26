class Audio < ApplicationRecord
  enum render_type: { plane: 0, markdown: 1, html: 2, mfm: 3}
  enum visibility: { public_share: 0, do_not_share: 1, followers_share: 2, scopings_share: 3, direct_share: 4 }
  belongs_to :account
  has_many :item_audios
  has_many :audios, through: :item_audios
  #has_one_attached :video
end
