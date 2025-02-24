
module ItemJsonData
  def item_data(item)
    item_data_json = item.as_json(only: [
      :aid,
      :content,
      :sensitive,
      :warning_message,
      :foreign,
      :created_at,
      :updated_at,
    ])
    account_data_json = with_account_data(item.account)
    item_data_json['account'] = account_data_json
    images_array_json = []
    item_data_json['reactions'] = item_reactions(item.reactions)
    return item_data_json
  end
end