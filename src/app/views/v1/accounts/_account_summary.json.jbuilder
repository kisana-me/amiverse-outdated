json.extract! account,
  :aid,
  :name,
  :name_id,
  :description,
  :followers_counter,
  :following_counter,
  :cache

json.icon_url account.icon_url
json.banner_url account.banner_url

json.badges do
  json.array! account.badges do |badge|
    json.extract! badge,
      :aid,
      :name
    json.url badge.image_url(variant_type: 'badges')
  end
end