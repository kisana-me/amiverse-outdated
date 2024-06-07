class SearchController < ApplicationController
  before_action :logged_in_account
  def index
    if params[:query].present?
      items = Item.where(deleted: false)
                    .order(created_at: :desc)
                    .search(params[:query])
    
      @page = current_page(page_param: params[:page])
      @pages = total_page(objects: items)
      limit = 10
      offset = paged_offset(page: @page, per_page: limit)
      @items = Item.where(deleted: false)
                    .order(created_at: :desc)
                    .search(params[:query], limit: limit, offset: offset)
    else
      @items = []
    end
  end
end