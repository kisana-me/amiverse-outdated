class ItemsController < ApplicationController
  before_action :logged_in_account, except: %i[ show ]
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :set_new_item, only: %i[ new new_reply new_quote ]
  include ActivityPub
  include Format

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
      :reactions,
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
  def show
  end
  def new
  end
  def edit
  end
  def create
    @item = Item.new(item_params)
    @item.account = @current_account
    @item.aid = generate_aid(Item, 'aid')
    if params[:item][:selected_images].present?
      params[:item][:selected_images].each do |aid|
        image = Image.find_by(aid: aid)
        @item.images << image
      end
    end
    if params[:item][:replied].present?
      replied = Item.find_by(aid: params[:item][:replied])
      #@item.replying = replied
    end
    if @item.save
      # if replied = Item.find_by(aid: params[:item][:replied])
      #   Reply.create(replier: @item, replied: replied)
      # end
      if quoted = Item.find_by(aid: params[:item][:quoted])
        Quote.create(quoter: @item, quoted: quoted)
      end
      flash[:success] = '投稿しました'
      redirect_to item_url(@item.aid)
    else
      flash.now[:danger] = '失敗しました'
      render 'new'
    end
  end
  def update
    redirect_to items_url, notice: "未実装" 
  end
  def destroy
    redirect_to items_url, notice: "未実装" 
  end

  def new_reply
    @item = Item.new
    @replied = get_item(aid: params[:item_aid])
    render 'items/new', locals: { initial_replied: params[:item_aid] }
  end
  def new_quote
    @item = Item.new
    @quoted = get_item(aid: params[:item_aid])
    render 'items/new', locals: { initial_quoted: params[:item_aid] }
  end
  def diffuse
    @item = get_item(aid: params[:item_aid])
    # 拡散する
    redirect_to items_url, notice: "未実装" 
  end

  private

  def get_item(aid: params[:aid])
    Item.find_by(
      aid: aid,
      visibility: :public_share,
      status: :shared,
      deleted: false
    )
  end
  def set_item()
    @item = get_item
  end
  def set_new_item
    @item = Item.new
  end
  def item_params
    params.require(:item).permit(
      # customize #
      :render_type,
      :layout_type,
      :visibility,
      :usage_type,
      :language,
      # main #
      :content,
      :media,
      :selected_images,
      :selected_audios,
      :selected_videos,
      :sensitive,
      :caution_message,
      # sub #
      :silent,
      :draft,
      :activitypub
    )
  end
end