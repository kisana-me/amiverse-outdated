class ImagesController < ApplicationController
  include DataStream
  before_action :logged_in_account
  before_action :set_image

  def show
    send_noblob_stream(
      @image.image,
      treat_image(@image.aid, 'images')
    )
  end
  def show_icon
    send_noblob_stream(
      @image.image,
      treat_image(@image.aid, 'icons')
    )
  end
  def show_banner
    send_noblob_stream(
      @image.image,
      treat_image(@image.aid, 'banners')
    )
  end
  def create
    @image = Image.new(image_params)
    @image.account = @current_account
    @image.aid = generate_aid(Image, 'aid')
    if @image.save
      flash[:success] = "アップロードしました"
      redirect_to settings_storage_path
      Rails.logger.info('test')
      @image.process_image
      Rails.logger.info('end')
    else
      flash[:danger] = "アップロードできませんでした#{@image.errors.full_messages.join(", ")}"
      redirect_to settings_storage_path
    end
  end
  def update
  end
  def destroy
  end
  private
  def set_image
    @image = Image.find_by(
      aid: params[:aid],
      deleted: false
    )
  end
  def image_params
    params.require(:image).permit(
      :image_data,
      :name,
      :description,
      :sensitive,
      :warning_message,
      :private
    )
  end
end