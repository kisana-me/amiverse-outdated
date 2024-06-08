class ItemsController < ApplicationController
  before_action :logged_in_account, except: %i[ show ]
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :set_new_item, only: %i[ new new_reply new_quote ]
  include ActivityPub
  include Format

  def index
    items = @current_account.items.where(
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
    # 事前にアップロード #
    if params[:media]
      params[:media].each do |m|
        case m.content_type
        when /\Aimage/
          image = Image.new(image: m)
          image.account = @current_account
          image.aid = generate_aid(Image, 'aid')
          image.name = m.original_filename if image.name.blank?
          if image.save
            @item.selected_images = @item.selected_images.nil? ? [] : @item.selected_images
            @item.selected_images << image.aid
          else
          end
          @item.errors.add(:base, "画像エラーメッセージ")
        when /\Aaudio/
          Rails.logger.info("音声ファイルです")
          # 音声ファイルの場合の処理
        when /\Avideo/
          Rails.logger.info("動画ファイルです")
          # 動画ファイルの場合の処理
        else
          Rails.logger.info("その他のファイルです")
          # その他のファイルの場合の処理
        end
      end
    end
    # 関連付け前処理 #
    if params[:item][:replied].present? # 返信
      replied = Item.find_by(aid: params[:item][:replied])
      @item.replier.new(replier: @item, replied: replied)
    end
    if params[:item][:quoted].present? # 引用
      quoted = Item.find_by(aid: params[:item][:quoted])
      @item.quoter.new(quoter: @item, quoted: quoted)
    end
    #########
    @item.account = @current_account
    @item.aid = generate_aid(Item, 'aid')
    if @item.save!
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
      :sensitive,
      :caution_message,
      # sub #
      :silent,
      :draft,
      :activitypub,
      selected_images: [],
      selected_audios: [],
      selected_videos: []
    )
  end
end