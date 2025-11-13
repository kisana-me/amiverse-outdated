json.array! @items do |item|
  json.partial! 'v1/items/item', item: item
end