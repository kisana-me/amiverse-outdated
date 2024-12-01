class V1::ItemsController < V1::ApplicationController
  before_action :api_logged_in_account, only: %i[ create ]
  before_action :set_item, only: %i[ show ]
  include ActivityPub

  # def index
  #   @items = paged_items(params[:page])
  #   render json: @items.map {|item|
  #     serialize_item(item)
  #   }
  # end
  def show
    render json: item_data(@item)
  end
  def create
    @item = Item.new(
      content: params[:content]
    )
    @item.account = @current_account
    @item.aid = generate_aid(Item, 'aid')
    if @item.save
      render json: { is_done: true, item_aid: @item.aid }
    else
      render json: { is_done: false }
    end
  end
  private
  def set_item
    @item = Item.find_by(
      aid: params[:aid],
      visibility: :public_share,
      status: :shared,
      deleted: false
    )
  end
end