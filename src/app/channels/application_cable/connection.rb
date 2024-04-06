module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_account
    def connect
      self.current_account = current_account
    end
    protected
    def current_account
      return unless cookies.signed[:amiverse_uid].present?
      return unless cookies.signed[:amiverse_rtk].present?
      db_session = Session.find_by(
        uuid: cookies.signed[:amiverse_uid],
        deleted: false
      )
      if BCrypt::Password.new(db_session.session_digest).is_password?(cookies.signed[:amiverse_rtk])
        sessions = AccountSession.where(
          session: db_session
        )
        account_session = sessions.order(current: :desc).first
        account = Account.find_by(
          id: account_session.account_id,
          deleted: false
        )
        return account
      end
      nil
    end
  end
end
