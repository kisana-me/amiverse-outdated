Rails.application.config.to_prepare do
  custom_config_file = Rails.root.join('config/x/custom_config.yml')
  if File.exist?(custom_config_file)
    custom_config = YAML.load_file(custom_config_file)[Rails.env]
    if custom_config
      custom_config.each do |key, value|
        Rails.application.config.x.send("#{key}=", value)
      end
    end
  else
    Rails.application.config.x.initial = true
  end
end