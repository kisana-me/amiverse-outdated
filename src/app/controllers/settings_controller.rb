class SettingsController < ApplicationController
  before_action :logged_in_account
  def index
    
  end
  def profile
    @images = Image.where(account_id: @current_account.id)
  end
  
  def storage
    @images = Image.where(account_id: @current_account.id)
    @videos = Video.where(account_id: @current_account.id)
    @image = Image.new
    @video = Video.new
  end
  def security_and_authority
    begin
      db_session = Session.find_by(
        uuid: cookies.signed[:amiverse_uid],
        deleted: false
      )
      if BCrypt::Password.new(db_session.session_digest).is_password?(cookies.signed[:amiverse_rtk])
        account_sessions = AccountSession.where(session: db_session)
        account_ids = account_sessions.pluck(:account_id)
        @logged_in_accounts = Account.where(id: account_ids)
      else
        @logged_in_accounts = []
      end
    rescue
      @logged_in_accounts = []
    end
  end
end
