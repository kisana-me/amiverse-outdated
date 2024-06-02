class ImagesController < ApplicationController
  before_action :logged_in_account
  before_action :set_image

  def create
    @image = Image.new(image_params)
    @image.account = @current_account
    @image.aid = generate_aid(Image, 'aid')
    @image.name = @image.image.original_filename if @image.name.blank?
    if @image.save
      flash[:success] = "アップロードしました"
      redirect_to settings_storage_path
    else
      flash[:danger] = "アップロードできませんでした#{@image.errors.full_messages.join(", ")}"
      redirect_to settings_storage_path
    end
  end
  def update
  end
  def destroy
    @image.deleted = true
    @image.variants_delete
    if @image.save
      flash[:success] = "削除しました"
      redirect_to settings_storage_path
    else
      flash[:danger] = "削除できません"
      redirect_to settings_storage_path
    end
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
      :image,
      :name,
      :description,
      :render_type,
      :sensitive,
      :caution_message,
      :visibility,
      :limitation
    )
  end
end