json.set!(
  '@context', [
    'https://www.w3.org/ns/activitystreams',
    'https://w3id.org/security/v1',
    {
      "Key": "sec:Key",
      "manuallyApprovesFollowers": "as:manuallyApprovesFollowers",
      "sensitive": "as:sensitive",
      "Hashtag": "as:Hashtag",
      "quoteUrl": "as:quoteUrl",
      "toot": "http://joinmastodon.org/ns#",
      "Emoji": "toot:Emoji",
      "featured": "toot:featured",
      "discoverable": "toot:discoverable",
      "schema": "http://schema.org#",
      "PropertyValue": "schema:PropertyValue",
      "value": "schema:value",
      "misskey": "https://misskey-hub.net/ns#",
      "_misskey_content": "misskey:_misskey_content",
      "_misskey_quote": "misskey:_misskey_quote",
      "_misskey_reaction": "misskey:_misskey_reaction",
      "_misskey_votes": "misskey:_misskey_votes",
      "isCat": "misskey:isCat",
      "vcard": "http://www.w3.org/2006/vcard/ns#"
    }
  ]
)

json.type 'Person'
json.id full_front_url("/@#{@account.name_id}")
json.url full_front_url("/@#{@account.name_id}")
json.tag []
json.published @account.created_at
json.discoverable true
json.attachment []
json.manuallyApprovesFollowers false
json.name @account.name
json.summary ""

json.icon do
  json.type 'Image'
  json.mediaType 'image/webp'
  json.name ''
  json.sensitive false
  json.url @account.icon_url
end

json.image do
  json.type 'Image'
  json.mediaType 'image/webp'
  json.name ''
  json.sensitive false
  json.url @account.banner_url
end

json.preferredUsername @account.name_id
json.inbox full_front_url("/@#{@account.name_id}/inbox")
json.outbox full_front_url("/@#{@account.name_id}/outbox")
json.followers full_front_url("/@#{@account.name_id}/followers")
json.following full_front_url("/@#{@account.name_id}/following")
json.featured full_front_url("/@#{@account.name_id}/collections/featured")
json.tag []
json.sharedInbox full_front_url('/inbox')

json.endpoints do
  json.sharedInbox full_front_url('/inbox')
end

json.publicKey do
  json.id full_front_url("/@#{@account.name_id}#main-key")
  json.type 'Key'
  json.owner full_front_url("/@#{@account.name_id}")
  json.publicKeyPem @account.ap_public_key
end
