class FeedController < ApplicationController
  before_action :logged_in_account, only: %i[ tl follow current group ]
  def index
    items = Item.where(
      silent: false,
      visibility: :public_share,
      status: :shared,
      deleted: false
    ).order(id: :desc).includes(
      :account,
      :images,
      :videos,
      #:reactions,
      :emojis,
      :replying,
      :repliers,
      :quoting,
      :quoters
    )
    @page = current_page(page_param: params[:page])
    @pages = total_page(objects: items)
    @items = paged_objects(page: @page, objects: items)
  end
  def follow
    @items = @current_account.following
      .includes(:items)
      .map(&:items)
      .flatten.uniq
      .sort_by(&:created_at).reverse
  end
end