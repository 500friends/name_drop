require 'active_support/dependencies/autoload'

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
end
