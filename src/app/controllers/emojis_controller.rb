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
    #if @emoji.custom
    #  extension = File.extname(params[:emoji][:image].original_filename).delete_prefix(".")
    #  @emoji.image.attach(
    #    key: "/emojis/#{@emoji.aid}.#{extension}",
    #    io: (params[:emoji][:image]),
    #    filename: "#{@emoji.aid}.#{extension}"
    #  )
    #end
    if @emoji.save
      #if @emoji.custom
      #  treat_image(@emoji.aid, 'emojis', Emoji)
      #  treat_image(@emoji.aid, 'tb-emojis', Emoji)
      #end
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
      :description,
      :sensitive
    )
  end
end
