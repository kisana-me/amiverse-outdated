class Client < ApplicationRecord
  has_many :sessions
  has_many :accounts, through: :sessions
end
