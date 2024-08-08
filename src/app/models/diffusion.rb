class Diffusion < ApplicationRecord
  belongs_to :diffuser, foreign_key: 'diffuser_id', class_name: 'Account'
  belongs_to :diffused, foreign_key: 'diffused_id', class_name: 'Item'
  scope :with_diffused_at, -> {
    select('items.id, items.content, diffusions.created_at AS timestamp, \'diffusion\' AS type')
      .joins(:diffused)
  }
end
