class Reply < ApplicationRecord
  belongs_to :replier, foreign_key: 'replier_id', class_name: 'Item'
  belongs_to :replied, foreign_key: 'replied_id', class_name: 'Item'
end
