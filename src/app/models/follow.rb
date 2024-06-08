class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: 'follower_id', class_name: 'Account'
  belongs_to :followed, foreign_key: 'followed_id', class_name: 'Account'
end
