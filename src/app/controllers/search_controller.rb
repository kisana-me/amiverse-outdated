class SearchController < ApplicationController
  before_action :logged_in_account
  def index
    if params[:query].present?
      items = Item.where(deleted: false).order(created_at: :desc)
        .search(params[:query], limit: 200, sort: ['created_at:desc']) # 検索limit
      @page = current_page(page_param: params[:page])
      @pages = total_page(objects: items)
      limit = 30
      offset = paged_offset(page: @page, per_page: limit)
      item_ids = Item.where(deleted: false).order(created_at: :desc)
        .search(params[:query], limit: limit, offset: offset, sort: ['created_at:desc']).map(&:id)
      @items = Item.where(
          id: item_ids,
          visibility: :public_share,
          status: :shared,
          deleted: false
        ).order(created_at: :desc).includes(
          :account,
          :images,
          :videos,
          :reactions,
          :emojis,
          :replying,
          :repliers,
          :quoting,
          :quoters
        )
    else
      @items = []
    end
  end
end