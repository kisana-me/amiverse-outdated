json.array! items do |c|
  if c[:object].is_a?(Item)
    json.object 'item'
    json.item do
      json.partial! 'v1/items/item', item: c[:object]
    end
  elsif c[:object].is_a?(Diffusion)
    json.object 'diffuse'
    json.item do
      json.partial! 'v1/items/item', item: c[:object].diffused
    end
    json.diffuser do
      json.partial! 'v1/accounts/account_summary', account: c[:object].diffuser
    end
  end
end
