class Invitation < ApplicationRecord
  belongs_to :creator, class_name: 'Account'
  has_many :account_invitations
  has_many :accounts, through: :account_invitations
end
