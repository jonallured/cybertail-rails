module Cybertail
  def self.config
    @config ||= create_config
  end

  private_class_method def self.create_config
    attributes = load_config
    Struct.new('Config', *attributes.keys, keyword_init: true)
    Struct::Config.new(attributes)
  end

  private_class_method def self.load_config
    credentials = Rails.application.credentials
    name = ENV.fetch('CREDS_GROUP', 'invalid').to_sym
    group = credentials[name]

    raise "CREDS_GROUP '#{name}' not found" unless group

    map_config(group)
  end

  private_class_method def self.map_config(group)
    {
      heroku_signature: group[:heroku_signature],
      hub_signature: group[:hub_signature],
      sidekiq_admin_password: group.dig(:sidekiq_admin, :password),
      sidekiq_admin_username: group.dig(:sidekiq_admin, :username)
    }
  end
end

Cybertail.config
