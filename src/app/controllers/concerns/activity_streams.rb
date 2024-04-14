module ActivityStreams
  # 作成
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