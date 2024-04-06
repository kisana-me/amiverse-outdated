module Format
  def login_account_data(account)
    return account.as_json(only: [
      :aid,
      :name,
      :name_id,
      :icon_id,
      :banner_id,
      :followers_counter,
      :following_counter,
      :meta,
      :cache,
      :discoverable,
      :manually_approves_followers,
    ])
  end
  def account_data(account)
    account_data_json = account.as_json(only: [
      :aid,
      :name,
      :name_id,
      :icon_id,
      :banner_id,
      :summary,
      :location,
      :followers_counter,
      :following_counter,
      :items_counter,
      :birthday,
      :created_at,
      :meta,
      :cache,
      :bot,
      :kind
    ])
    account_data_json['icon_url'] = image_url(account.icon_id, 'icon')
    account_data_json['banner_url'] = image_url(account.banner_id, 'banner')
    account_data_json['items'] = items_data(account.items)
    return account_data_json
  end
  def with_account_data(account)
    account_data_json = account.as_json(only: [
      :aid,
      :name,
      :name_id,
      :icon_id,
      :banner_id,
      :meta,
      :cache,
      :bot,
      :kind
    ])
    account_data_json['icon_url'] = ''
    account_data_json['banner_url'] = ''
    return account_data_json
  end
  def item_data(item)
    item_data_json = item.as_json(only: [
      :aid,
      :kind,
      :meta,
      :cache,
      :content,
      :sensitive,
      :warning_message,
      :foreign,
      :created_at,
      :updated_at,
    ])
    # account
    account_data_json = with_account_data(item.account)
    item_data_json['account'] = account_data_json
    return item_data_json
  end
  def items_data(items)
    return items.map {|item|
      item_data(item)
    }
  end
  def image_data(image)
    return image.as_json(only: [
      :aid,
      :name,
      :description,
      :sensitive,
      :warning_message,
      :meta
    ])
  end
end