class Administrator::ItemsController < Administrator::ApplicationController
  before_action :set_item, only: %i[ ]
  def index
    @items = Item.all
  end
  def show
  end
  private
  def set_item
    @item = Item.find(params[:id])
  end
end