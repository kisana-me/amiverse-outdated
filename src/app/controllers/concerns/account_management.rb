module AccountManagement
  include ActivityPub

  def find_account(str)
    nid, host, local = nid_host_separater(str)
    if local
      query = nid
    else
      query = nid + '@' + host
    end

    account = Account.find_by(
      name_id: query,
      deleted: false
    )
    if !account && !local
      account = ap_account(nid: nid, host: host)
    end
    return account
  end
  def find_local_account(nid)
    return Account.find_by(
      name_id: nid,
      deleted: false
    )
  end

  def account_checker() # 使用量監視
    # @current_account.checker = 
  end

  def nid_host_separater(str)
    nid = ''
    host = ''
    if str.include?('@')
      parts = str.split('@')
      case parts.length
      when 3
        nid, host = parts.pop(2)
      when 2
        if str.start_with?('@')
          nid = parts.last
        else
          nid, host = parts
        end
      when 1
        nid = parts.first
      end
    else
      nid = str
    end
    return nid, host, (host.blank? || host == URI.parse(ENV['APP_URL']).host)
  end
end