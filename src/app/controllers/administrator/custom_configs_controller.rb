class Administrator::CustomConfigsController < Administrator::ApplicationController
  def index
    @custom_configs = CustomConfig.all
  end
  def new
    @custom_config = CustomConfig.new
  end
  def create
    @custom_config = CustomConfig.new(custom_config_params)
    @custom_config.aid = generate_aid(CustomConfig, 'aid')
    if @custom_config.save
      flash[:success] = "作成しました"
      redirect_to administrator_root_path
      custom_config = CustomConfig.last
      Rails.application.config.x.custom_config = custom_config
    else
      flash.now[:danger] = "失敗しました"
      render 'new'
    end
  end
  def edit
  end
  def update
    redirect_to administrator_root_path, notice: 'Settings updated successfully.'
  end
  private
  def custom_config_params
    params.require(:custom_config).permit(
      :server_name,
      :server_version,
      :server_description,
      :open_registrations,
      :theme_color,
      :maintainer_name,
      :maintainer_email,
      :accounts,
      :items,
      :images,
      :audios,
      :videos,
      :emojis,
      :reactions,
      :activitypub,
      languages: [],
      urls: [],
      others: [],
      meta: [],
      ap_meta: []
    )
  end
end
