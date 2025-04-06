module ActivityStreams

  ### General ###

  def as_wrap(id:, type:, actor:, object:)
    return {
      "@context": "https://www.w3.org/ns/activitystreams",
      "id": File.join(actor.ap_uri, id),
      "type": type,
      "actor": actor.ap_uri,
      "object": object
    }
  end

  ### Create ###

  def as_create(
    id:,
    to: ["https://www.w3.org/ns/activitystreams#Public"],
    cc: [], actor:, object:, published:
    )
      {
        "@context": ["https://www.w3.org/ns/activitystreams", {}],
        "type": "Create",
        "id": File.join(ENV['FRONT_URL'], id),
        "published": published.utc.iso8601,
        "to": to,
        "cc": cc,
        "actor": File.join(ENV['FRONT_URL'], '@'+ actor.name_id),
        "object": object
      }
    end

  ### Note ###

  def as_note(item:, to: [], cc: [])
    {
      "@context": "https://www.w3.org/ns/activitystreams",
      "type": "Note",
      "id": "https://amiverse.net/items/#{item.aid}",
      "url": "https://amiverse.net/items/#{item.aid}",
      "attributedTo": "https://amiverse.net/#{item.account.aid}",
      "published": item.created_at,
      "to": [
        "https://www.w3.org/ns/activitystreams#Public"
      ],
      "cc": [
        "https://amiverse.net/#{item.account.aid}/followers"
      ],
      "sensitive": false,
      "conversation": "",
      "content": item.content,
      "attachment": [],
      "tag": [],
      "replies": {
        # collections
      }
    }
  end
end