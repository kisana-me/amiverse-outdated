class Role < ApplicationRecord
  has_many :account_role
  has_many :accounts, through: :account_role
end