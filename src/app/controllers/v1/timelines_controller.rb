class V1::TimelinesController < V1::ApplicationController
before_action :api_logged_in_account, except: %i[ current ]    
  #skip_before_action :verify_authenticity_token
  def index
    items = Item.where(
      silent: false,
      visibility: :public_share,
      status: :shared,
      deleted: false
    ).order(id: :desc).includes(
      :images,
      :videos,
      :reactions,
      :emojis,
      :replying,
      :repliers,
      :quoting,
      :quoters,
      :canvases,
      account: [:icon, :badges]
    )
    diffusions = Diffusion.order(created_at: :desc).limit(1000)
    # 新生成機
    items_time_array = items.map do |item|
      { object: item, time: item.created_at }
    end
    diffusions_time_array = diffusions.map do |diffusion|
      { object: diffusion, time: diffusion.created_at }
    end
    fulltimeline = (items_time_array + diffusions_time_array).sort_by { |entry| entry[:time] }.reverse
    @page = current_page(page_param: params[:page])
    @pages = total_page(objects: fulltimeline)
    @timeline = paged_objects(page: @page, objects: fulltimeline)
    
    render json: timeline_data(@timeline)
  end
  def follow
    @items = @current_account.following
      .includes(:items)
      .map(&:items)
      .flatten.uniq
      .sort_by(&:created_at).reverse
    render json: @items.map {|item|
      item_data(item)
    }
  end
  def current
    @items = paged_items(params[:page])
    render json: items_data(@items)
  end
  def group
  end
  private
end