class ItemsController < ApplicationController
  before_action :logged_in_account, only: %i[ index show new create update destroy ]
  before_action :set_item, only: %i[ show edit update destroy ]
  include ActivityPub
  include Format

  def index
    offset_item = 0
    limit_item = 9
    offset_item = params[:o_i] unless params[:o_i].nil?
    limit_item = params[:l_i] unless params[:l_i].nil?

    @items = Item.offset(offset_item.to_i).limit(limit_item.to_i)
  end
  def show
    # ?reactionが?個
  end
  def new
  end
  def edit
  end
  def create
    @item = Item.new(item_params)
    @item.account = @current_account
    @item.aid = generate_aid(Item, 'aid')
    if @item.save
      if params[:item][:selected_images].present?
        params[:item][:selected_images].each do |aid|
          if image = Image.find_by(aid: aid)
            this_item_image_params = {
              image: image,
              item: @item
            }
            ItemImage.create(this_item_image_params)
          end
        end
      end
      if params[:item][:selected_videos].present?
        params[:item][:selected_videos].each do |aid|
          if video = Video.find_by(aid: aid)
            this_item_video_params = {
              video: video,
              item: @item
            }
            ItemVideo.create(this_item_video_params)
          end
        end
      end
      if replied = Item.find_by(aid: params[:item][:replied])
        Reply.create(replier: @item, replied: replied)
      end
      if quoted = Item.find_by(aid: params[:item][:quoted])
        Quote.create(quoter: @item, quoted: quoted)
      end
      flash[:success] = '投稿しました'
      redirect_to item_url(@item.aid)
      # 範囲が全世界ならば
      ## APが有効ならば
      ### 他のインスタンスにフォロワーがいれば
      if params[:item][:to_url].present?
        Rails.logger.info('========ap note send========')
        deliver(
          actor: @item.account,
          body: ap_pre_create_note(item: @item),
          to_url: params[:item][:to_url]
        )
      end
      #ActionCable.server.broadcast('current_channel', item_data(@item))
    else
      flash[:success] = '失敗しました。'
      render :new
    end
  end
  def update
    if @item.update(item_params)
      flash[:success] = '投稿を編集しました。'
      redirect_to item_url(@item.aid)
    else
      render :edit
    end
  end
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
    def set_item
      @item = Item.where('BINARY aid = ?', params[:aid]).first
    end
    def item_params
      params.require(:item).permit(:content,
                                  :sensitive)
    end
end