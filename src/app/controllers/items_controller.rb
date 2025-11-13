class ItemsController < ApplicationController
  before_action :logged_in_account, except: %i[ show ]
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :set_new_item, only: %i[ new new_reply new_quote ]
  include ActivityPub

  def index
    # items = @current_account.items.where(
    #   deleted: false
    # ).order(id: :desc).includes(
    #   :account,
    #   :images,
    #   :videos,
    #   :reactions,
    #   :emojis,
    #   :replying,
    #   :repliers,
    #   :quoting,
    #   :quoters,
    #   :canvases
    # )
    # diffusions = Diffusion.where(diffuser: @current_account).includes(:diffused).all
    # @combined = (items.map { |item| { type: 'item', object: item, timestamp: item.created_at } } +
    #              diffusions.map { |diffusion| { type: 'diffusion', object: diffusion.diffused, timestamp: diffusion.created_at } })
    #              .sort_by { |entry| entry[:timestamp] }

    # @page = current_page(page_param: params[:page])
    # @pages = total_page(objects: @combined)
    # @items = paged_objects(page: @page, objects: @combined)
    items_query = Item.with_diffused_at.to_sql
    diffusions_query = Diffusion.with_diffused_at.to_sql

    union_query = "#{items_query} UNION ALL #{diffusions_query} ORDER BY timestamp DESC"

    # 実行して結果をActiveRecordリレーションとして扱う
    @items = ActiveRecord::Base.connection.execute(union_query)

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
    if @item.save
      redirect_to item_url(@item.aid), success: t('.success')
      # action cable
      # activity pub
      # ap_create_note(item: @item)
    else
      flash.now[:danger] = t('.danger')
      render 'new'
    end
  end
  def update
    redirect_to items_url, notice: "未実装" 
  end
  def destroy
    redirect_to items_url, notice: "未実装" 
  end
  def reload
    @item = get_item(aid: params[:item_aid])
  end
  def new_reply
    #@item = Item.new
    @item = get_item(aid: params[:item_aid])
    #render 'items/new', locals: { initial_replied: params[:item_aid] }
  end
  def new_quote
    #@item = Item.new
    @item = get_item(aid: params[:item_aid])
    #render 'items/new', locals: { initial_quoted: params[:item_aid] }
  end
  def new_react
    @item = get_item(aid: params[:item_aid])
    @emojis = Emoji.all
    #render 'items/show', locals: { emojis: emojis }
  end
  def diffuse
    @item = get_item(aid: params[:item_aid])
    this_diffusion_params = {
      diffuser_id: @current_account.id,
      diffused_id: @item.id
    }
    if Diffusion.exists?(this_diffusion_params)
      Diffusion.where(this_diffusion_params).delete_all
      flash.now[:success] = '拡散を取り消しました'
    elsif Diffusion.new(this_diffusion_params).save
      flash.now[:success] = '拡散しました'
    else
      flash.now[:danger] = '拡散に失敗しました'
      render 'items/show', status: :unprocessable_entity
    end
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
    return unless @item = get_item
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
      selected_videos: [],
      selected_canvases: []
    )
  end
end