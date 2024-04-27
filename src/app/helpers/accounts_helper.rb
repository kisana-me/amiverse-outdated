module AccountsHelper
  def name_id_host_separater(str)
    name_id = ''
    host = ''
    if str.include?('@')
      parts = str.split('@')
      case parts.length
      when 3
        name_id, host = parts.pop(2)
      when 2
        if str.start_with?('@')
          name_id = parts.last
        else
          name_id, host = parts
        end
      when 1
        name_id = parts.first
      end
    else
      name_id = str
    end
    return name_id, host, (host.blank? || host == URI.parse(ENV['APP_URL']).host)
  end
  def find_account_by_nid(nid)
    name_id, host, own_server = name_id_host_separater(nid)
    if own_server
      search_id = name_id
    else
      search_id = name_id + '@' + host
    end
    Account.find_by(name_id: search_id,
      activated: true,
      locked: false,
      silenced: false,
      suspended: false,
      frozen: false,
      deleted: false)
  end
end