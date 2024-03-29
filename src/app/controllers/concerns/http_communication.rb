module HttpCommunication
  require 'net/http'
  require 'net/https'
  def http_get(url, headers)
    uri = URI.parse(url)
    req = Net::HTTP.new(uri.host, uri.port)
    res = req.get(url, headers)
    return req, res
  end
  def http_post(url, headers, data)
    uri = URI.parse(url)
    req = Net::HTTP.new(uri.host, uri.port)
    res = req.post(uri.path, data, headers)
    return req, res
  end
  def https_get(url, headers)
    uri = URI.parse(url)
    req = Net::HTTP.new(uri.host, uri.port)
    req.use_ssl = true
    res = req.get(url, headers)
    return req, res
  end
  def https_post(url, headers, data)
    uri = URI.parse(url)
    req = Net::HTTP.new(uri.host, uri.port)
    req.use_ssl = true
    res = req.post(uri.path, data, headers)
    return req, res
  end
end