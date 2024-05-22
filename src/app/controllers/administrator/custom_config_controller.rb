class Administrator::CustomConfigController < Administrator::ApplicationController
  def index
    @settings = Rails.configuration.x
    Rails.logger.info("=~=====#{@settings.version}")
  end
  def update
    new_settings = params.require(:settings).permit(
      :initial,
      :administrators,
      :name,
      :version
    )
    CustomConfig.update_settings(new_settings.to_h)

    redirect_to administrator_root_path, notice: 'Settings updated successfully.'
  end
end
