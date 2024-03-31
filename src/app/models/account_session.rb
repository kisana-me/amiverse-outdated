class AccountSession < ApplicationRecord
  belongs_to :account
  belongs_to :session
end
