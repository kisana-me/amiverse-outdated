class V1::ItemsController < V1::ApplicationController
  before_action :api_logged_in_account, except: %i[ show ]
  before_action :set_item, only: %i[ show ]
  include ActivityPub

  # def index
  #   @items = paged_items(params[:page])
  #   render json: @items.map {|item|
  #     serialize_item(item)
  #   }
  # end
  def show
  end
  def create
    @item = Item.new(
      content: params[:content]
    )
    @item.account = @current_account
    @item.aid = generate_aid(Item, 'aid')
    if @item.save
      @current_account.update(items_counter: @current_account.items.where(visibility: :public_share, status: :shared).count)
      render json: { is_done: true, item_aid: @item.aid }
    else
      render json: { is_done: false }
    end
  end

  def react
    item = Item.find_by(
      aid: params[:item_aid],
      visibility: :public_share,
      status: :shared,
      deleted: false
    )
    emoji = Emoji.find_by(
      aid: params[:emoji_aid],
      deleted: false
    )
    this_react_params = {
      account_id: @current_account.id,
      emoji_id: emoji.id,
      item_id: item.id
    }
    if Reaction.exists?(this_react_params)
      Reaction.where(this_react_params).delete_all
      render json: { status: 'deleted' }
    elsif Reaction.new(this_react_params).save
      render json: { status: 'reacted' }
    else
      render json: { status: 'error' }
    end
  end

  def diffuse
    item = get_item(aid: params[:item_aid])
    diffusion_attrs = {
      diffuser_id: @current_account.id,
      diffused_id: item.id
    }
    if Diffusion.exists?(diffusion_attrs)
      Diffusion.where(diffusion_attrs).delete_all
      status = 'deleted'
    else
      status = Diffusion.create(diffusion_attrs).persisted? ? 'diffused' : 'error'
    end
    render json: { status: status }
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
  def get_item(aid: params[:aid])
    Item.find_by(
      aid: aid,
      visibility: :public_share,
      status: :shared,
      deleted: false
    )
  end
end