class AccountBadge < ApplicationRecord
  belongs_to :account
  belongs_to :badge
end
