module ApSender
  include HttpCommunication
  include HttpSignature

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
  def ap_accept_undo_follow(received_body:, followed:, follower:)#???
    ap_send(
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
    ap_send(
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

  ### GENERAL ###

  def ap_send(id:, type:, actor:, object:, destination:)
    body = {
      "@context": "https://www.w3.org/ns/activitystreams",
      "type": type,
      "id": File.join(actor.activitypub_id, id),
      "actor": actor.activitypub_id,
      "object": object
    }
    to_url = File.join(destination.activitypub_id, 'inbox')
    from_url = ENV['APP_HOST']
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
end