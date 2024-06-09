class FeedController < ApplicationController
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
      account: [:icon]
    )
    @page = current_page(page_param: params[:page])
    @pages = total_page(objects: items)
    @items = paged_objects(page: @page, objects: items)
  end
  def following
    items = @current_account.following
      .includes(:items)
      .map(&:items)
      .flatten.uniq
      .sort_by(&:created_at).reverse
    @page = current_page(page_param: params[:page])
    @pages = total_page(objects: items)
    offset = paged_offset(page: @page)#paged_objects(page: @page, objects: items)
    # @items = @current_account.following
    #   .includes(:items)
    #   .map(&:items)
    #   .flatten.uniq
    #   .sort_by(&:created_at).reverse
    following_ids = @current_account.following.pluck(:id)
    @items = Item.joins(:account)
      .where(accounts: { id: following_ids })
      .includes(:account)
      .order(created_at: :desc)
      .limit(30)
      .offset(offset)
      .uniq
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
    @page = current_page(page_param: params[:page])
    @pages = total_page(objects: items)
    @items = paged_objects(page: @page, objects: items)
  end
end