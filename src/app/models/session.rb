class Session < ApplicationRecord
  belongs_to :account
  belongs_to :client
end
