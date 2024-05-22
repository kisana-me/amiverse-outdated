class CustomConfig

  def self.update_settings(new_settings)
    custom_config_file = Rails.root.join('config/x/custom_config.yml')
    env_custom_config = YAML.load_file(custom_config_file) || {}
    custom_config = env_custom_config[Rails.env] || {}

    new_settings.each do |key, value|
      custom_config[key.to_s] = value
      Rails.configuration.x.send("#{key}=", value)
    end

    env_custom_config[Rails.env] = custom_config
    File.open(custom_config_file, 'w') { |f| f.write(env_custom_config.to_yaml) }
  end
end
