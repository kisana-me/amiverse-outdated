json.extract! item,
  :aid,
  :content,
  :sensitive,
  :foreign,
  :created_at,
  :updated_at

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
  
  json.array! grouped_reactions do |reaction|
    json.reaction_count item.reactions.where(emoji_id: reaction.emoji_id).count
    json.emoji do
      json.extract! reaction.emoji,
        :aid,
        :name,
        :name_id,
        :created_at
    end
  end
end