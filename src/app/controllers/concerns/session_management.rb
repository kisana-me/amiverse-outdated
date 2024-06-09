module SessionManagement

  # LOGIN

  def log_in(account)
    new_session = true
    # 古参
    if cookies.signed[:a_uid].present? &&
    cookies.signed[:a_rtk].present? &&
    doubt_client = Client.find_by(
      uuid: cookies.signed[:a_uid],
      deleted: false
    )
      if BCrypt::Password.new(doubt_client.client_digest).is_password?(cookies.signed[:a_rtk])
        client = doubt_client
        new_session = false
      end
    end
    if new_session # 新規
      uuid = SecureRandom.uuid
      token = SecureRandom.urlsafe_base64
      client = Client.create(
        uuid: uuid,
        client_digest: digest(token),
        ip_address: request.remote_ip,
        user_agent: request.user_agent
      )
      db_session = Session.create(
        uuid: SecureRandom.uuid,
        account: account,
        client: client
      )
      client.update(primary_session: db_session.id)
    else # 古参紐づけ
      unless client.accounts.where(sessions: { deleted: false }, deleted: false).include?(account)
        db_session = Session.create(
          uuid: SecureRandom.uuid,
          account: account,
          client: client
        )
        client.update(primary_session: db_session.id)
      end
    end
    if new_session # cookie更新
      secure_cookies = ENV["RAILS_SECURE_COOKIES"].present?
      cookies.permanent.signed[:a_uid] = {
        value: uuid,
        domain: :all,
        expires: 1.month.from_now,
        secure: secure_cookies,
        httponly: true
      }
      cookies.permanent.signed[:a_rtk] = {
        value: token,
        domain: :all,
        expires: 1.month.from_now,
        secure: secure_cookies,
        httponly: true
      }
    end
    session[:logged_in] = true
  end

  # ACCOUNT

  def current_account
    begin
      if cookies.signed[:a_uid].present? && cookies.signed[:a_rtk].present?
        client = Client.find_by(uuid: cookies.signed[:a_uid], deleted: false)
        if BCrypt::Password.new(client.client_digest).is_password?(cookies.signed[:a_rtk])
          #client.accounts.where(sessions: { deleted: false }, deleted: false)
          db_sessions = Session.where(client: client, deleted: false)
          if primary_session = db_sessions.include?(id: client.primary_session)
            account_session = primary_session
          else
            account_session = db_sessions.first
          end
          account = account_session.account
          account = nil if account.deleted # 生きたアカウントを
          session[:logged_in] = true if account
          return account if account
        end
      end
      endcookies_logout
      nil
    rescue
      cookies_logout
      nil
    end
  end

  # CHANGE

  def change_account(account) # 健全なアカウントか確認した方がいい
    return {status: false, message: '変更先アカウントが指定されていません'} unless account
    return {status: false, message: 'ブラウザのログイン情報が読み込めません'} unless cookies.signed[:a_uid].present? || cookies.signed[:a_rtk].present?
    return {status: false, message: 'ログイン中のアカウントです'} if account == @current_account
    begin
      client = Client.find_by(
        uuid: cookies.signed[:a_uid],
        deleted: false
      )
      if client && BCrypt::Password.new(client.client_digest).is_password?(cookies.signed[:a_rtk])
        db_session = Session.find_by(client: client, account: account)
        client.update(primary_session: db_session.id)
        return {status: true, message: '変更しました'}
      else
        return {status: false, message: 'アカウントの承認に失敗しました'}
      end
    rescue
      return {status: false, message: '不明な内部エラー'}
    end
  end

  # LOGOUT

  def log_out(account: @current_account, client: nil)
    path_client_check = false
    if client
      path_client_check = true
    end
    client = Client.find_by(
      uuid: cookies.signed[:a_uid],
      deleted: false
    ) if cookies.signed[:a_uid].present? && !client
    if cookies.signed[:a_rtk].present? && BCrypt::Password.new(client.client_digest).is_password?(cookies.signed[:a_rtk]) || path_client_check
      Session.where(client: client, account: account, deleted: false).update_all(deleted: true)
      if db_session = Session.find_by(client: client, deleted: false)
        client.update(primary_session: db_session.id)
        account = db_session.account # 健全なアカウントを
        return false if account.deleted # 生きたアカウントを
        return true
      else
        client.update(deleted: true)
        cookies_logout
        return true
      end
    else
      return false
    end
  end

  # ALL LOGOUT

  def all_log_out
    client = Client.find_by(
      uuid: cookies.signed[:a_uid],
      deleted: false
    ) if cookies.signed[:a_uid].present?
    if BCrypt::Password.new(client.client_digest).is_password?(cookies.signed[:a_rtk])
      Session.where(client: client).update_all(deleted: true)
      client.update(deleted: true)
    end
    cookies_logout
  end

  # ACCOUNTS

  def current_accounts
    client = Client.find_by(
      uuid: cookies.signed[:a_uid],
      deleted: false
    )
    return nil unless client && BCrypt::Password.new(client.client_digest).is_password?(cookies.signed[:a_rtk])
    return client.accounts.where(sessions: { deleted: false }, deleted: false) # 健全なアカウントを
    rescue
      nil
  end

  # CLIENTS

  def current_clients
    return @current_account.clients.where(deleted: false)
  end

  private

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  def cookies_logout
    #session.delete(:?)
    session[:logged_in] = false
    cookies.delete(:a_uid)
    cookies.delete(:a_rtk)
    @current_account = nil
  end
end
