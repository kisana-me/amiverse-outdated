Rails.application.config.to_prepare do
  begin
    if ActiveRecord::Base.connection.table_exists?('custom_configs')
        if custom_config = CustomConfig.last
          Rails.application.config.x.custom_config = custom_config
          Rails.application.config.x.initial = false
        else
          Rails.application.config.x.custom_config = initial_custom_config
          Rails.application.config.x.initial = true
        end
    end
  rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid => e
    Rails.logger.warn "Database not created yet, skipping custom config initializer: #{e.message}"
  end
end

private

class InitialCustomConfig
  attr_accessor :server_name, :server_version, :server_description, :open_registrations,
                :languages, :theme_color, :urls, :others, :maintainer_name,
                :maintainer_email, :accounts, :items, :images, :audios, :videos,
                :emojis, :reactions, :meta, :published_at, :activitypub, :ap_meta

  def initialize
    @server_name = 'Amiverse'
    @server_version = 'v.0.0.5'
    @server_description = ''
    @open_registrations = false
    @languages = []
    @theme_color = ''
    @urls = []
    @others = []
    @maintainer_name = ''
    @maintainer_email = ''
    @accounts = 0
    @items = 0
    @images = 0
    @audios = 0
    @videos = 0
    @emojis = 0
    @reactions = 0
    @meta = {}
    @published_at = nil
    @activitypub = false
    @ap_meta = {}
  end
end

def initial_custom_config
  InitialCustomConfig.new
end