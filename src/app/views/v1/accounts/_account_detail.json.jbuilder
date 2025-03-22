json.extract! account,
  :aid,
  :name,
  :name_id,
  :description,
  :location,
  :followers_counter,
  :following_counter,
  :items_counter,
  :created_at,
  :meta,
  :cache

json.public_key ''
json.icon_url account.icon_url
json.banner_url account.banner_url

json.items do
  json.array! account.items.order(created_at: :desc) do |item|
    json.partial! 'v1/items/item', item: item
  end
end
