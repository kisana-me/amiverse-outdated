class Quote < ApplicationRecord
  belongs_to :quoter, foreign_key: 'quoter_id', class_name: 'Item'
  belongs_to :quoted, foreign_key: 'quoted_id', class_name: 'Item'
end
