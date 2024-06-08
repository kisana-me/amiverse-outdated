module TrendManagement
  include Tools
  def frequent_words(items:)
    natto = Natto::MeCab.new
    word_count = Hash.new(0)
    items.each do |post|
      natto.parse(post.content) do |n|
        if n.surface.length > 3
          word_count[n.surface] += 1
        end
      end
    end
    sorted_words = word_count.sort_by { |_, count| -count }.first(Rails.application.config.x.server_property.trend_search_words)#単語の頻出度順、大きくするとmeilisearchの回数が増える
    word_usage_count = {}
    sorted_words.to_a.each do |word, _|
      word_usage_count[word] = [items.search(word, limit: 500).count, _] # 検索結果数
    end
    word_usage_count.sort_by { |_, counts| -counts[0] }.first(30).to_h#投稿の数順
  end
  def current_trend(limit: 30)
    if Rails.application.config.x.last_trend_at.blank?
      Rails.application.config.x.last_trend_at = nil
    end
    if Rails.application.config.x.last_trend_at && Rails.application.config.x.last_trend_at > Time.now - Rails.application.config.x.server_property.trend_interval * 60
      return Rails.application.config.x.trend.first(limit)
    else
      #last_trend = Trend.last
      # if last_trend && last_trend.created_at > Time.now - 60 * 60
      #   Rails.logger.info("=======3")
      #   last_trend.words.first(limit)
      # end
      trend = frequent_words(items: get_newer_items)
      Trend.create!(aid: generate_aid(Trend, 'aid'), words: trend)
      Rails.application.config.x.last_trend_at = Time.now
      Rails.application.config.x.trend = trend
      trend.first(limit)
    end
  end

  private

  def get_newer_items
    base_limit = Rails.application.config.x.server_property.trend_samplings
    base_time = Time.now - Rails.application.config.x.server_property.trend_interval * 60
    recent_items = Item.where(deleted: false).where('created_at > ?', base_time).order(created_at: :desc)
    if recent_items.count < base_limit
      return Item.where(deleted: false)
              .order(created_at: :desc)
              .limit(base_limit)
    end
    return Item.where(deleted: false).where('created_at > ?', base_time).order(created_at: :desc)
  end
end