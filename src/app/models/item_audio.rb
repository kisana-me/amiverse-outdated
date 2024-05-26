class ItemAudio < ApplicationRecord
  belongs_to :item
  belongs_to :audio
end
