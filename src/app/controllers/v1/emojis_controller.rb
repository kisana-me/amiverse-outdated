class V1::EmojisController < V1::ApplicationController
  # before_action :api_logged_in_account
  include Serializers

  def index
    emojis = Emoji.all
    render json: multiple_general(emojis)
  end

  private

  def single_general(emoji)
    hash = general_perse(emoji)
    json = JSON.generate(hash)
    return json
  end

  def multiple_general(emojis)
    array = emojis.map { |emoji| general_perse(emoji) }
    JSON.generate(array)
  end

  def general_perse(emoji)
    hash = {
      aid: emoji.aid,
      name: emoji.name,
      name_id: emoji.name_id,
      usage_type: emoji.usage_type,
      sensitive: emoji.sensitive
    }
    return hash
  end
end