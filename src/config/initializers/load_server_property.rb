Rails.application.config.to_prepare do
  begin
    if ActiveRecord::Base.connection.table_exists?('server_properties')
      if server_property = ServerProperty.last
        Rails.application.config.x.server_property = server_property
        Rails.application.config.x.initial = false
      else
        Rails.application.config.x.server_property = initial_server_property
        if Account.last
          Rails.application.config.x.initial = false
        else
          Rails.application.config.x.initial = true
        end
      end
    end
  rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid => e
    Rails.logger.warn "Database not created yet, skipping custom config initializer: #{e.message}"
  end
end

private

class InitialServerProperty
  attr_accessor :server_name, :server_version, :server_description, :open_registrations,
                :languages, :theme_color, :urls, :others, :maintainer_name,
                :maintainer_email, :accounts, :items, :images, :audios, :videos,
                :emojis, :reactions, :meta, :published_at, :activitypub, :ap_meta,
                :trend_interval, :trend_samplings, :trend_search_words,
                :ga4, :ga4_id

  def initialize
    @server_name = 'Amiverse'
    @server_version = 'v.0.0.5'
    @server_description = 'Amiverseは次世代のソーシャルメディアです'
    @open_registrations = false
    @languages = ['ja']
    @theme_color = '#22ff22'
    @urls = ['https://amiverse.net/']
    @others = []
    @maintainer_name = 'Amiverse Net'
    @maintainer_email = 'amiverse@amiverse.net'
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
    @trend_interval = 30
    @trend_samplings = 200
    @trend_search_words = 100
    @ga4 = true
    @ga4_id = 'VP5CN519Q8'
  end
end

def initial_server_property
  InitialServerProperty.new
end