class Invitation < ApplicationRecord
  belongs_to :creator, class_name: 'Account', foreign_key: 'account_id'
  has_many :account_invitations
  has_many :accounts, through: :account_invitations
end
