module ActivityPub
  include HttpCommunication
  include HttpSignature
  include ActivityStreams

  ### GENERAL ###

  def ap_create(id:, to:, cc:, actor:, object:, published:)
    {
      "@context": ["https://www.w3.org/ns/activitystreams", {}],
      "type": "Create",
      "id": File.join(ENV['APP_HOST'], id),
      "published": published.utc.iso8601,
      "to": [
        "https://www.w3.org/ns/activitystreams#Public"
      ],
      "cc": [
        "https://amiverse.net/@#{item.account.name_id}/followers"
      ],
      "actor": File.join(ENV['APP_HOST'], '@'+ actor.name_id),
      "object": object
    }
  end

  ### FOLLOW ###

  def ap_follow(followed:, follower:, id:)
    ap_send(
      id: "follow/#{id}",
      type: 'Follow',
      actor: follower,
      object: followed.activitypub_id,
      destination: followed
    )
  end
  def ap_undo_follow(followed:, follower:, id:)
    undo_object = {
      "id": File.join(follower.activitypub_id, "follow/#{id}"),
      "type": 'Follow',
      "actor": follower.activitypub_id,
      "object": followed.activitypub_id
    }
    ap_send(
      id: 'undo_follow',
      type: 'Undo',
      actor: follower,
      object: undo_object,
      destination: followed
    )
  end
  def ap_accept_follow(followed:, follower:, id:)
    accept_object = {
      "id": id,
      "type": 'Follow',
      "actor": follower.activitypub_id,
      "object": followed.activitypub_id
    }
    ap_send(
      id: 'accept_follow',
      type: 'Accept',
      actor: followed,
      object: accept_object,
      destination: follower
    )
  end
  def ap_accept_undo_follow(received_body:, followed:, follower:)
    ap_send(
      id: 'undo_follow',
      type: 'Accept',
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

  ### NOTE ###

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
  def delete_note()
  end
  def ap_send(id:, type:, actor:, object:, destination:)
    body = {
      "@context": "https://www.w3.org/ns/activitystreams",
      "type": type,
      "id": File.join(actor.activitypub_id, id),
      "actor": actor.activitypub_id,
      "object": object
    }
    deliver(
      actor: actor,
      body: body,
      to_url: File.join(destination.activitypub_id, 'inbox')
    )
  end
  def read(data)
    body = JSON.parse(data['body'])
    headers = data['headers']
    context = body['@context']
    id = body['id']
    object = body['object'] unless body['object'].nil?
    status = 'Info:処理開始'
    received_params = {
      received_at: body['received_at'].to_s,
      headers: headers.to_json,
      body: body.to_json,
      context: context.to_json,
      activitypub_id: id.to_s,
      status: status
    }
    received_params[:object] = object.to_json if object.present?
    received_params[:activity_type] = body['type'].to_s if body['type'].present?
    saved_data = ActivityPubReceived.create!(received_params)
    ########
    # 解析 #
    ########
    case body['type']
    when 'Follow'
      followed = account(object)
      follower = account(body['actor'])
      if followed && follower
        follow_params = {
          followed: followed,
          follower: follower,
          uuid: id # uuidではなくid
        }
        if Follow.exists?(follow_params)
          status = 'Info:フォロー済み'
        else
          follow_params.merge!(accepted: true)
          Follow.create(follow_params)
          status = 'Success:フォロー完了'
        end
        ap_accept_follow(
          followed: followed,
          follower: follower,
          id: body['id']
        )
      else
        status = 'Error:アカウントが存在しない'
      end
    when 'Like'
      #actorがobjectをいいねする
    when 'Dislike'
    ## リアクション系
    when 'Accept'
      case object['type']
      when 'Follow'
        followed = account(object['object'])
        follower = account(object['actor'])
        follow_params = {
          followed: followed,
          follower: follower,
          uuid: object['id']
        }
        if follow = Follow.find_by(follow_params)
          if follow.accepted
            status = 'Info:フォロー承認済み'
          else
            follow.update(accepted: true)
            status = 'Success:フォロー承認完了'
          end
        else
          status = 'Error:指定のフォローが見つからない'
        end
      when 'Undo'
        Rails.logger.info('----------')
        Rails.logger.info('-----Undo-----')
        case object['object']['type']
        when 'Follow'
          Rails.logger.info('-----Undo---Follow--')
          #Follow.where(this_follow_params).delete_all
        else
        end
      else
      end
    when 'Reject'
    when 'Undo'
      case object['type']
      when 'Follow'
        followed = account(object['object'])
        follower = account(body['actor'])
        if followed && follower
          follow_params = {
            followed: followed,
            follower: follower
          }
          if Follow.exists?(follow_params)
            Follow.where(follow_params).delete_all
            status = 'S0'
          else
            status = 'E4'
          end
        else
          status = 'E0'
        end
      else
        #その他
      end
    ## CRUD系
    when 'Create'
      #actorアカウントがあるか確認
      case object['type']
      when 'Note'
        attributed_to = account(object['attributedTo'])
        item = Item.new(
          content: object['content'].force_encoding('UTF-8'),
          sensitive: object['sensitive']
        )
        item.account = attributed_to
        item.aid = generate_aid(Item, 'aid')
        item.kind = 'plane'
        if item.save
          status = 'Success:投稿完了'
        end
      else
        #その他
      end
      #objectを作成する
    when 'Update'
    when 'Delete'
      case object
      when String
        #objectがuser形式であれば
        #find_account_by_nidして
        #あればdeleted = true
        #なければ終わり
        saved_data.delete
        #煩わしいので↑
        if account = Account.find_by(activitypub_id: object)
          account.update(deleted: true) 
          status = 'S0'
        else
          status = 'S1'
        end
      else
      end
    else
      #その他
    end
    # status更新
    saved_data.status = status
    saved_data.save
    return status
  end
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
  def id_to_uri(id)
    name_id, host, own_server = name_id_host_separater(id)
    uri = ''
    if own_server
    else
      uri = URI::HTTPS.build(
        host: host,
        path: '/.well-known/webfinger',
        query: 'resource=acct:' + name_id + '@' + host
      )
      req,res = https_get(
        uri.to_s,
        {}
      )
      data = JSON.parse(res.body)
      self_links = data['links'].select { |link| link['rel'] == "self" }
      uri = self_links.first['href']
    end
    return uri
  end
  def account(uri)
    #サーバー判定
    if URI.parse(uri).host == URI.parse(ENV['APP_HOST']).host
      account = Account.find_by(name_id: uri.split(/[@]/).last)
    else
      server = server(URI.parse(uri).host)
      #アカウントあるかないか
      if account = Account.find_by(activitypub_id: uri)
      else
        account = explore_account(uri)
      end
    end
    return account
  end
  def deliver(actor:, body:, to_url:, from_url: ENV['APP_HOST'])
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
  def get_name_id(uri, preferredUsername)
    host = URI.parse(uri).host
    preferredUsername + '@' + host
  end
  private
  def explore_account(uri)
    #server確認紐づけ
    req,res = https_get(
      uri,
      {'Accept' => 'application/activity+json'}
    )
    res.code == 200
    data = JSON.parse(res.body)
    account = Account.new(
      name: data['name'].present? ? data['name'] : '',
      name_id: get_name_id(data['id'], data['preferredUsername']),
      aid: generate_aid(Account, 'aid'),
      activitypub_id: uri,
      #serverと紐づけ
      foreigner: true,
      activitypub: true,
      activated: true,
      summary: data['summary'].present? ? data['summary'] : '',
      discoverable: data['discoverable'].nil? ? true : data['discoverable'].present?,
      locked: data['manuallyApprovesFollowers'].nil? ? true : data['manuallyApprovesFollowers'].present?,
      public_key: data['publicKey']['publicKeyPem']
    )
    account.save!(context: :skip)
    return account
  end
end