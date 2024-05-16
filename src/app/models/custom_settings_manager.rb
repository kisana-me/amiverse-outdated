class CustomSettingsManager
  def self.update(key, value)
    config_file = Rails.root.join('config', 'x', 'custom_settings.yml')
    settings = YAML.load_file(config_file)
    settings[Rails.env][key] = value
    File.open(config_file, 'w') { |f| f.write(settings.to_yaml) }
    Rails.application.config.x.send("#{key}=", value)
    Rails.logger.info(Rails.application.config.x.name)
    #CustomSettingsManager.update('name', 'Amiverse')
  end
end