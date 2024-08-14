class Administrations::BadgesController < Administrations::ApplicationController
  before_action :set_badge, only: %i[ show create edit update destroy ]

  def index
    @badges = Badge.all
  end
  def show
  end
  def new
    @badge = Badge.new
  end
  def create
    @badge = Badge.new(badge_params)
    @badge.aid = generate_aid(Badge, 'aid')
    if @badge.save
      flash[:success] = "badgeを作成しました"
      redirect_to administrations_root_path
    else
      flash.now[:danger] = "作成できませんでした"
      render 'new'
    end
  end
  def edit
  end
  def update
    if @badge.update(badge_params)
      flash[:success] = '変更しました'
      redirect_to administrations_root_path
    else
      flash.now[:danger] = "更新できませんでした"
      render 'edit'
    end
  end
  def destroy
    # 本当に消す？
  end

  private

  def set_badge
    @badge = Badge.find_by(aid: params[:aid])
  end
  def badge_params
    params.require(:badge).permit(
      :aid,
      :name,
      :description,
      :image
    )
  end
end