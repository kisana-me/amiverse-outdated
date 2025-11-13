module ActivityPub
  include HttpCommunication
  include HttpSignature
  include ActivityStreams
  include ApDeliver

  ### Item -> Note ###

  def ap_create_note(item:)
    # to = メンションなどあれば
    # cc = 連携中のサーバーなど
    note = as_note(item: item)
    body = as_create(
      id: "/@#{item.account.name_id}/create_items/#{item.aid}",
      cc: ["https://amiverse.net/@#{item.account.name_id}/followers"],
      actor: item.account,
      object: note,
      published: item.created_at
    )
    apd_deliver(
      body: body,
      account: item.account,
      destination: 'https://misskey.io/inbox'
    )
  end

  ### Follow ###

  def ap_follow(followed:, follower:, uid:)
    body = as_wrap(
      id: "follow/#{uid}",
      type: 'Follow',
      actor: follower,
      object: followed.ap_uri
    )
    apd_deliver(body: body, account: follower, destination: followed)
  end
  def ap_undo_follow(followed:, follower:, uid:)
    undo_object = {
      "id": File.join(follower.ap_uri, "follow/#{uid}"),
      "type": 'Follow',
      "actor": follower.ap_uri,
      "object": followed.ap_uri
    }
    body = as_wrap(
      id: "undo_follow/#{uid}",
      type: 'Undo',
      actor: follower,
      object: undo_object
    )
    apd_deliver(body: body, account: follower, destination: followed)
  end
  def ap_accept_follow(followed:, follower:, id:)
    accept_object = {
      "id": id,
      "type": 'Follow',
      "actor": follower.ap_uri,
      "object": followed.ap_uri
    }
    body = as_wrap(
      id: 'accept_follow',
      type: 'Accept',
      actor: followed,
      object: accept_object
    )
    apd_deliver(body: body, account: followed, destination: follower)
    # aps_send(
    #   id: 'accept_follow',
    #   type: 'Accept',
    #   actor: followed,
    #   object: accept_object,
    #   destination: follower
    # )
  end
  def ap_accept_undo_follow(received_body:, followed:, follower:)#???
    aps_send(
      id: 'undo_follow',
      type: 'Accept',
      actor: followed,
      object: received_body,
      destination: follower
    )
  end
  def ap_reject_follow(follow_id:, followed:, follower:)
    reject_object = {
      id: follow_id,
      type: 'Follow',
      actor: follower,
      object: followed
    }
    aps_send(
      id: 'undo_follow',
      type: 'Reject',
      actor: followed,
      object: received_body,
      destination: follower
    )
  end

  ### LIKE ###

  def ap_like()
  end
  def ap_undo_like()
  end

  # Account

  def ap_account(nid:, host:)
    # host(instance)の確認
    uri = apd_get_uri(nid: nid, host: host) # webfingerしてアカウントを認識
    # uriを改めてローカルで確認後、なければ(旧)explore_account(uri)する
    data = apd_get_data(url: uri)
    return nil unless data['id'] == uri
    #アカウントがあって正しくデータが返ってきたか確認(ないuriにgetしたら何が送られてくるのか調査しないと書けない)
    account = Account.new(
      name: data['name'].present? ? data['name'] : '',
      name_id: ap_name_id(pu_name: data['preferredUsername'], uri: uri),
      aid: generate_aid(Account, 'aid'),
      ap_uri: data['id'],
      #serverと紐づけ
      foreigner: true,
      activitypub: true,
      description: data['summary'].present? ? data['summary'] : '',
      discoverable: data['discoverable'].present? ? data['discoverable'] : true,
      auto_accept_follow: data['manuallyApprovesFollowers'].present? ? data['manuallyApprovesFollowers'] : false,
      ap_public_key: data['publicKey']['publicKeyPem']
    )
    account.save(context: :skip)
    return account
  end







  # ~~~~~~~~~~~

  def ap_pre_create_note(item:)
    body = {
      "@context": ["https://www.w3.org/ns/activitystreams", {}],
      "type": "Create",
      "id": "https://amiverse.net/items/#{item.aid}/create",
      "published": item.created_at.utc.iso8601,
      "to": [
        "https://www.w3.org/ns/activitystreams#Public"
      ],
      "cc": [
        "https://amiverse.net/@#{item.account.name_id}/followers"
      ],
      "actor": "https://amiverse.net/@#{item.account.name_id}",
      "object": {
        "type": "Note",
        "id": "https://amiverse.net/items/#{item.aid}",
        "url": "https://amiverse.net/items/#{item.aid}",
        "published": item.created_at.utc.iso8601,
        "to": [
          "https://www.w3.org/ns/activitystreams#Public"
        ],
        "cc": [
          "https://amiverse.net/@#{item.account.name_id}/followers"
        ],
        "attributedTo": "https://amiverse.net/@#{item.account.name_id}",
        "content": item.content
      }
    }
  end
  def ap_send(id:, type:, actor:, object:, destination:)
    body = {
      "@context": "https://www.w3.org/ns/activitystreams",
      "type": type,
      "id": File.join(actor.ap_uri, id),
      "actor": actor.ap_uri,
      "object": object
    }
    deliver(
      actor: actor,
      body: body,
      to_url: File.join(destination.ap_uri, 'inbox')
    )
  end
  # read 跡地
  def server(host)
    unless server = ActivityPubServer.find_by(host: host)
      server = explore_server(host)
    end
    return server
  end
  def explore_server(host)
    uri_0 = URI::HTTPS.build(
      host: host,
      path: '/.well-known/nodeinfo'
    )
    req_0,res_0 = https_get(
      uri_0.to_s,
      {'Accept': 'application/json'}
    )
    nodeinfo = JSON.parse(res_0.body)['links'].select { |link| link['rel'] == "http://nodeinfo.diaspora.software/ns/schema/2.0" }
    href = nodeinfo[0]['href']
    uri = URI::HTTPS.build(
      host: host,
      path: URI.parse(href).path
    )
    req,res = https_get(
      uri.to_s,
      {'Accept': 'application/json'}
    )
    data = JSON.parse(res.body)
    server_params = {
      server_id: generate_aid(ActivityPubServer, 'server_id'),
      host: host
    }
    server_params[:name] = data['metadata']['nodeName'] if data['metadata']['nodeName'].present?
    server_params[:description] = data['metadata']['nodeDescription'] if data['metadata']['nodeDescription'].present?
    server_params[:software_name] = data['software']['name'] if data['software']['name'].present?
    server_params[:software_version] = data['software']['version'] if data['software']['version'].present?
    if data['metadata']['maintainer'].present?
      server_params[:maintainer_name] = data['metadata']['maintainer']['name'] if data['metadata']['maintainer']['name'].present?
      server_params[:maintainer_email] = data['metadata']['maintainer']['email'] if data['metadata']['maintainer']['email'].present?
    end
    server_params[:open_registrations] = data['openRegistrations'] if data['openRegistrations'].present?
    server_params[:theme_color] = data['metadata']['themeColor'] if data['metadata']['themeColor'].present?
    ActivityPubServer.create(server_params)
  end
  def account(uri)
    #サーバー判定
    if URI.parse(uri).host == URI.parse(ENV['FRONT_URL']).host
      account = Account.find_by(name_id: uri.split(/[@]/).last)
    else
      #server = server(URI.parse(uri).host)
      if account = Account.find_by(ap_uri: uri)
      else
        account = explore_account(uri)
      end
    end
    return account
  end
  def deliver(actor:, body:, to_url:, from_url: ENV['FRONT_URL'])
    headers, statement, http_signature = create_signed_headers(actor: actor, body: body, to_url: to_url, from_url: from_url)
    req,res = https_post(
      to_url,
      headers,
      body.to_json
    )
    ActivityPubDelivered.create(
      to_url: to_url,
      digest: http_signature[1],
      to_be_signed: http_signature[2],
      signature: http_signature[3],
      statement: statement,
      content: body.to_json,
      response: res.body
    )
  end
  def front_deliver(body, name_id, private_key, from_url, to_url, public_key)
    headers, digest, to_be_signed, sign, statement = sign_headers(body, name_id, private_key, from_url, to_url)
    req,res = http_post(
      'http://front:3000/outbox',
      {Authorization: "Bearer #{ENV['SERVER_PASSWORD']}",
      'Content-Type' => 'application/json'
      },{
      to_url: to_url,
      headers: headers,
      body: body}.to_json
    )
    ActivityPubDelivered.create(
      to_url: to_url,
      digest: digest,
      to_be_signed: to_be_signed,
      signature: sign,
      statement: statement,
      content: body.to_json,
      response: res.body)
  end
  def ap_name_id(pu_name:, uri:)
    return pu_name + '@' + URI.parse(uri).host
  end

  private

  def explore_account(uri) ### 解体中
    host = URI.parse(uri).host
    path = URI.parse(uri).path
    current_time = Time.now.utc.httpdate
    actor = Account.find_by(name_id: 'kisana')
    #server確認紐づけ
    headers = {
      'Host': host,
      'Date': current_time
    } 
    statement_headers = '(request-target) host date'
    signed_string = build_signed_string(headers: headers, statement_headers: statement_headers, request_target: 'get', path: path)
    
    signature = generate_signature(actor.private_key, signed_string)
    statement = [
      "keyId=\"https://#{URI.parse(ENV['FRONT_URL']).host}/@#{actor.name_id}#main-key\"",
      'algorithm="rsa-sha256"',
      "headers=\"#{statement_headers}\"",
      "signature=\"#{signature}\""
    ].join(',')
    headers = headers.merge({
      'Signature': statement,
      'Authorization': "Signature #{statement}",
      'User-Agent': "Amiverse v.0.0.5 (+https://#{URI.parse(ENV['FRONT_URL']).host}/)",
      'Accept' => 'application/activity+json'
    })
  end
end