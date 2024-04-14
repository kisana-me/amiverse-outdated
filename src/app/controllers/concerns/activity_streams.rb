module ActivityStreams
  # 作成
  def as_note(item:, to: [], cc: [])
    {
      "@context": "https://www.w3.org/ns/activitystreams",
      "type": "Note",
      "id": "https://amiverse.net/items/#{item.aid}",
      "url": "https://amiverse.net/items/#{item.aid}",
      "published": item.created_at,
      "to": [
        "https://www.w3.org/ns/activitystreams#Public"
      ],
      "cc": [
        "https://amiverse.net/#{item.account.aid}/followers"
      ],
      "attributedTo": "https://amiverse.net/#{item.account.aid}/followers",
      "content": item.content
    }
  end
end