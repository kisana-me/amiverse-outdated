class SearchController < ApplicationController
  before_action :logged_in_account
  def index
    if params[:query].present?
      @items = Item.search(params[:query])
    else
      @items = []
    end
  end
end