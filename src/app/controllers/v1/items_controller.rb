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
    # @item = Item.new(
    #   content: params[:content],
    #   sensitive: params[:sensitive]
    # )
    # @item.account_id = @current_account.id
    # @item.item_id = generate_aid(Item, 'item_id')
    # @item.uuid = SecureRandom.uuid
    # @item.item_type = 'plane'
    # if @item.save
    #   #front_deliver(create_note(@item), @current_account.name_id, @current_account.private_key, 'https://amiverse.net', 'https://mstdn.jp/inbox', @current_account.public_key)
    #   ActionCable.server.broadcast('items_channel', serialize_item(@item))
    #   render json: {success: true}
    # else
    #   render json: {success: false}
    # end
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