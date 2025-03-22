class FeedsController < ApplicationController
  before_action :logged_in_account, except: %i[ index current ]
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
  end
  def following
    items = @current_account.following
      .includes(:items)
      .map(&:items)
      .flatten.uniq
      .sort_by(&:created_at).reverse
    # @page = current_page(page_param: params[:page])
    # @pages = total_page(objects: items)
    # offset = paged_offset(page: @page)#paged_objects(page: @page, objects: items)
    # @items = @current_account.following
    #   .includes(:items)
    #   .map(&:items)
    #   .flatten.uniq
    #   .sort_by(&:created_at).reverse
    following_ids = @current_account.following.pluck(:id)
    # @items = Item.joins(:account)
    #   .where(accounts: { id: following_ids })
    #   .includes(:account)
    #   .order(created_at: :desc)
    #   .limit(30)
    #   .offset(offset)
    #   .uniq
    diffusions = Diffusion.where(diffuser_id: following_ids).order(created_at: :desc).limit(1000)
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
  end
  def current
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
      account: [:icon]
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
  end
end