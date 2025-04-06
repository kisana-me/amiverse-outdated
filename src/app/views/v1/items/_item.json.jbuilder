json.extract! item,
  :aid,
  :content,
  :sensitive,
  :caution_message,
  :silent,
  :render_type,
  :layout_type,
  :visibility,
  :usage_type,
  :status,
  :language,
  :viewed_counter,
  :replied_counter,
  :diffused_counter,
  :quoted_counter,
  :listed_counter,
  :foreign,
  :activitypub,
  :created_at,
  :updated_at

if item.activitypub
  json.extract! item,
    :ap_status,
    :ap_uri,
    :ap_url
end

json.diffused item.diffused_accounts.include?(@current_account)

json.quoters_counter item.quoters.size
json.diffusers_counter item.diffused_accounts.size
json.repliers_counter item.repliers.size
json.reactions_counter item.reactions.size

json.account do
  json.partial! 'v1/accounts/account_summary', account: item.account
end

json.images do
  json.array! item.images do |image|
    json.extract! image,
      :aid,
      :name,
      :description,
      :sensitive,
      :caution_message,
      :meta,
      :cache
    json.url image.image_url
  end
end

json.videos do
  json.array! item.videos do |video|
    json.extract! video,
      :aid,
      :name,
      :description,
      :sensitive,
      :caution_message,
      :meta,
      :cache
    json.url video.video_url
  end
end

json.reactions do
  grouped_reactions = item.reactions.joins(:emoji).group("emoji_id")
  user_reacted_emoji_ids = if @current_account
    item.reactions.where(account: @current_account).pluck(:emoji_id).to_set
  else
    Set.new
  end
  json.array! grouped_reactions do |reaction|
    json.reaction_count item.reactions.where(emoji_id: reaction.emoji_id).count
    json.emoji do
      json.extract! reaction.emoji,
        :aid,
        :name,
        :name_id,
        :created_at
    end
    json.reacted user_reacted_emoji_ids.include?(reaction.emoji_id)
  end
end