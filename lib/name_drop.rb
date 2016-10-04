require 'net/https'
require 'uri'
require 'active_support/dependencies/autoload'
require 'active_support/inflector'
require 'active_support/core_ext/object'
require 'active_support/core_ext/hash/indifferent_access'

module NameDrop
  extend ActiveSupport::Autoload

  class << self
    # Returns existing configuration, or a new configuration
    #
    # @return [NameDrop::Configuration] either predefined or a new instance
    def configuration
      @configuration ||= Configuration.new
    end

    # Sets configuration for NameDrop
    #
    # @param [NameDrop::Configuration] config
    def configuration=(config)
      @configuration = config
    end

    # Allows configuration of NameDrop through block
    #
    # @example Set account_id and access_token
    #   NameDrop.configure do |config|
    #     config.account_id = ENV['MENTION_API_ACCOUNT_ID']
    #     config.access_token = ENV['MENTION_API_ACCESS_TOKEN']
    #   end
    # @yieldreturn [NameDrop::Configuration] configuration
    def configure
      yield(configuration)
    end
  end

  eager_autoload do
    autoload :Configuration
    autoload :Client
    autoload :Error
  end

  module Resources
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base
      autoload :BaseFactory
      autoload :Alert
      autoload :Mention
      autoload :Share
    end
  end

  def self.eager_load!
    super
    NameDrop::Resources.eager_load!
  end
end

require 'name_drop/railtie' if defined?(Rails)
