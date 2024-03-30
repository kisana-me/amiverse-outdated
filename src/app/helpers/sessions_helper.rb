module SessionsHelper
  def log_in(account)
    uuid = SecureRandom.uuid
    token = SecureRandom.urlsafe_base64
    Session.create(
      account_id: account.id,
      uuid: uuid,
      session_digest: digest(token)
    )
    secure_cookies = ENV["RAILS_SECURE_COOKIES"].present?
    cookies.permanent.signed[:amiverse_aid] = {
      value: account.aid,
      domain: :all,
      expires: 1.year.from_now,
      secure: secure_cookies,
      httponly: true
    }
    cookies.permanent.signed[:amiverse_uid] = {
      value: uuid,
      domain: :all,
      expires: 1.year.from_now,
      secure: secure_cookies,
      httponly: true
    }
    cookies.permanent.signed[:amiverse_rtk] = {
      value: token,
      domain: :all,
      expires: 1.year.from_now,
      secure: secure_cookies,
      httponly: true
    }
    session[:logged_in] = true
    session[:current_account] = account
  end
  def logged_in?
    !@current_account.nil?
  end
  def current_account
    if session[:logged_in].present?
      unless session[:logged_in]
        return 
      end
    end
    if session[:current_account].present?
      return session[:current_account]
    else
      return unless cookies.signed[:amiverse_aid].present?
      return unless cookies.signed[:amiverse_uid].present?
      account = Account.find_by(
        aid: cookies.signed[:amiverse_aid],
        deleted: false
      )
      db_session = Session.find_by(
        account_id: account.id,
        uuid: cookies.signed[:amiverse_uid],
        deleted: false
      )
      if BCrypt::Password.new(db_session.session_digest).is_password?(cookies.signed[:amiverse_rtk])
        session[:current_account] = account
        return account
      end
      session[:logged_in] = false
      @current_account = nil
    end
  end
  def current_account?(account)
    account == current_account
  end
  def log_out
    account = Account.find_by(
      aid: cookies.signed[:amiverse_aid],
      deleted: false
    ) if cookies.signed[:amiverse_aid].present?
    session = Session.find_by(
      account_id: account.id,
      uuid: cookies.signed[:amiverse_uid],
      deleted: false
    ) if cookies.signed[:amiverse_uid].present?
    session.delete
    session[:logged_in] = false
    cookies.delete(:amiverse_aid)
    cookies.delete(:amiverse_uid)
    cookies.delete(:amiverse_rtk)
    @current_account = nil
  end
  private
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
