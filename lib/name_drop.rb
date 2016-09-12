require 'active_support/dependencies/autoload'
require 'active_support/inflector'
require 'active_support/core_ext/object'
require 'active_support/core_ext/hash/indifferent_access'

module NameDrop
  extend ActiveSupport::Autoload

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configuration=(config)
      @configuration = config
    end

    def configure
      yield configuration
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
