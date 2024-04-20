module SessionsHelper
  def log_in(account)
    new_session = true
    # 古参
    if cookies.signed[:amiverse_uid].present? &&
    cookies.signed[:amiverse_rtk].present? &&
    doubt_session = Session.find_by(
      uuid: cookies.signed[:amiverse_uid],
      deleted: false
    )
      if BCrypt::Password.new(doubt_session.session_digest).is_password?(cookies.signed[:amiverse_rtk])
        db_session = doubt_session
        new_session = false
      end
    end
    if new_session # 新規
      uuid = SecureRandom.uuid
      token = SecureRandom.urlsafe_base64
      db_session = Session.create!(
        uuid: uuid,
        session_digest: digest(token)
      )
      AccountSession.create(
        account: account,
        session: db_session,
        ip_address: '',
        user_agent: request.user_agent,
        current: true
      )
    else # 古参紐づけ
      AccountSession.where(
        session: db_session
      ).update_all(current: false)
      if current_account_session = AccountSession.find_by(
        account: account,
        session: db_session
      )
        unless current_account_session.current?
          current_account_session.update(current: true)
        end
      else
        AccountSession.create(
          account: account,
          session: db_session,
          ip_address: '',
          user_agent: request.user_agent,
          current: true
        )
      end
    end
    # cookie更新
    if new_session
      secure_cookies = ENV["RAILS_SECURE_COOKIES"].present?
      cookies.permanent.signed[:amiverse_uid] = {
        value: uuid,
        domain: :all,
        expires: 1.month.from_now,
        secure: secure_cookies,
        httponly: true
      }
      cookies.permanent.signed[:amiverse_rtk] = {
        value: token,
        domain: :all,
        expires: 1.month.from_now,
        secure: secure_cookies,
        httponly: true
      }
    end
    session[:logged_in] = true
    session[:current_account] = account
  end
  def logged_in?
    !@current_account.nil?
  end
  def current_account
    if session[:current_account].present?
      return session[:current_account]
    else
      if cookies.signed[:amiverse_uid].present? && cookies.signed[:amiverse_rtk].present? &&
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
          session[:current_account] = account
          session[:logged_in] = true
          return account
        end
      end
      session[:logged_in] = false
      session.delete(:current_account)
      cookies.delete(:amiverse_uid)
      cookies.delete(:amiverse_rtk)
      @current_account = nil
      return nil
    end
  end
  def current_account?(account)
    account == current_account
  end
  def change_account_session(account)
    return {status: false, message: '変更先アカウントが指定されていません'} unless account
    return {status: false, message: 'ブラウザのログイン情報が読み込めません'} unless cookies.signed[:amiverse_uid].present? || cookies.signed[:amiverse_rtk].present?
    return {status: false, message: 'ログイン中のアカウントです'} if account == @current_account
    begin
      db_session = Session.find_by(
        uuid: cookies.signed[:amiverse_uid],
        deleted: false
      )
      if BCrypt::Password.new(db_session.session_digest).is_password?(cookies.signed[:amiverse_rtk])
        AccountSession.where(session: db_session).update_all(current: false)
        AccountSession.where(session: db_session).find_by(account: account).update(current: true)
        session[:current_account] = account
        return {status: true, message: '変更しました'}
      else
        return {status: false, message: 'アカウントの承認に失敗しました'}
      end
    rescue
      return {status: false, message: '不明な内部エラー'}
    end
  end
  def log_out(account)
    db_session = Session.find_by(
      uuid: cookies.signed[:amiverse_uid],
      deleted: false
    ) if cookies.signed[:amiverse_uid].present?
    if BCrypt::Password.new(db_session.session_digest).is_password?(cookies.signed[:amiverse_rtk])
      AccountSession.where(session: db_session, account: account).delete_all
      if AccountSession.exists?(session: db_session)
        account_sessions = AccountSession.where(session: db_session)
        new_account_session = account_sessions.order(current: :desc).first
        account_sessions.update_all(current: false)
        new_account_session.update(current: true)
        session[:current_account] = account
        session[:logged_in] = true
      else
        db_session.delete
        session[:logged_in] = false
      end
    end
  end
  def all_log_out
    db_session = Session.find_by(
      uuid: cookies.signed[:amiverse_uid],
      deleted: false
    ) if cookies.signed[:amiverse_uid].present?
    if BCrypt::Password.new(db_session.session_digest).is_password?(cookies.signed[:amiverse_rtk])
      AccountSession.where(session: db_session).delete_all
      db_session.delete
    end
    session.delete
    session[:logged_in] = false
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
