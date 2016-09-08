module NameDrop
  class Configuration
    attr_accessor :account_id, :access_token

    def initialize
      @account_id = 'NotARealAccountID'
      @access_token = 'NotARealAccessToken'
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configuration=(config)
      @configuration = config
    end

    def configure
      yield(configuration)
    end
  end
end
