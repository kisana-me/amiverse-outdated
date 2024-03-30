class EmojisController < ApplicationController
  before_action :logged_in_account
  #before_action :set_item, only: %i[ show edit update destroy ]
  def index
    @emojis = Emoji.where(
      deleted: false
    )
  end
  def show
  end
  def new
    @emoji = Emoji.new
  end
  def create
    @emoji = Emoji.new(emoji_params)
    @emoji.account = @current_account
    @emoji.aid = generate_aid(Emoji, 'aid')
    if @emoji.save
      flash[:success] = '作成しました'
      redirect_to emojis_path
    else
      flash.now[:danger] = '作成できませんでした'
      render :new
    end
  end
  def edit
  end
  def update
  end
  def destroy
  end
  private
  def emoji_params
    params.require(:emoji).permit(
      :name,
      :name_id,
      :description
    )
  end
end
