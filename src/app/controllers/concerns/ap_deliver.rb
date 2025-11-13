module ApDeliver
  include HttpCommunication
  include HttpSignature

  # Generals

  def apd_deliver(body:, account:, destination:)
    to_url = File.join(destination.ap_uri, 'inbox')
    from_url = ENV['FRONT_URL']
    headers, statement, http_signature_data = create_signed_headers(actor: account, body: body, to_url: to_url, from_url: from_url)
    req,res = https_post(
      to_url,
      headers,
      body.to_json
    )
    ActivityPubDelivered.create(
      to_url: to_url,
      digest: http_signature_data[1],
      to_be_signed: http_signature_data[2],
      signature: http_signature_data[3],
      statement: headers,
      content: body.to_json,
      response: res.body
    )
  end

  # Fetches

  def apd_get_uri(nid:, host:)
    uri = URI::HTTPS.build(
      host: host,
      path: '/.well-known/webfinger',
      query: 'resource=acct:' + nid + '@' + host
    )
    req,res = https_get(
      uri.to_s,
      {}
    )
    data = JSON.parse(res.body)
    self_links = data['links'].select { |link| link['rel'] == "self" }
    uri = self_links.first['href']
    return uri
  end
  def apd_get_data(url:)
    # httpsignatureを使うならここでやる
    headers = {
      # 'Signature': statement,
      # 'Authorization': "Signature #{statement}",
      'User-Agent': "Amiverse v.0.0.1 (+https://#{URI.parse(ENV['FRONT_URL']).host}/)",
      'Accept' => 'application/activity+json'
    }
    req,res = https_get(
      url,
      headers
    )
    ActivityPubDelivered.create(
      to_url: url,
      signature: headers.to_json,
      response: res.body
    )
    return JSON.parse(res.body)
  end
end