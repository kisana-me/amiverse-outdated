class Administrations::ServerPropertiesController < Administrations::ApplicationController
  def index
    @server_property = ServerProperty.all
  end
  def new
    @server_property = ServerProperty.new
  end
  def create
    @server_property = ServerProperty.new(server_property_params)
    @server_property.aid = generate_aid(ServerProperty, 'aid')
    if @server_property.save
      Rails.application.config.x.server_property = @server_property
      Rails.application.config.x.initial = false
      flash[:success] = "作成しました"
      redirect_to administrations_root_path
    else
      flash.now[:danger] = "失敗しました"
      render 'new'
    end
  end
  def edit
  end
  def update
    redirect_to administrations_root_path, notice: 'Settings updated successfully.'
  end
  private
  def server_property_params
    params.require(:server_property).permit(
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
      :trend_interval,
      :trend_samplings,
      :trend_search_words,
      :ga4,
      :ga4_id,
      languages: [],
      urls: [],
      others: [],
      meta: [],
      ap_meta: []
    )
  end
end
