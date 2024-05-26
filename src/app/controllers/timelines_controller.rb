class TimelinesController < ApplicationController
  before_action :logged_in_account, only: %i[ tl follow current group ]
  def index
    
      param = params[:page].to_i
      page = param < 1 ? 1 : param
      limit_item = 10 # 表示件数
      offset_item = (page - 1) * limit_item # 開始位置
      @items = Item.where(
        silent: false,
        visibility: :public_share,
        status: :shared,
        deleted: false
      ).offset(offset_item.to_i).limit(limit_item.to_i).order(id: :desc).includes(
        :account,
        :images,
        :videos,
        #:reactions,
        :emojis,
        :replying,
        :repliers,
        :quoting,
        :quoters
      )
  end
  def tl
    redirect_to root_path
  end
  def follow
    @items = @current_account.following
      .includes(:items)
      .map(&:items)
      .flatten.uniq
      .sort_by(&:created_at).reverse
  end
  def current
    @items = paged_items(params[:page])
  end
  def group
  end
  private

end