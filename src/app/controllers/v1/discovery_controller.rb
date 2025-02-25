class V1::DiscoveryController < V1::ApplicationController
  include TrendManagement
  def index
    trend = current_trend()
    
    # トレンドデータをJSON形式に整形
    trend_data = {
      last_updated_at: Rails.application.config.x.last_trend_at,
      trends: trend.map do |word, count|
        {
          word: word,
          count: count.min
        }
      end
    }
    
    render json: trend_data
  end
  
  private
end