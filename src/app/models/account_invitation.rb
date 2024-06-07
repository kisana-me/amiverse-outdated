class AccountInvitation < ApplicationRecord
  belongs_to :account
  belongs_to :invitation
end
