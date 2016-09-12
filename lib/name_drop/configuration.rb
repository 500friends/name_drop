# Namespace for classes and modules that handle interaction with Mention API
#
# @since 0.1.0
module NameDrop
  # Holds configuration for Mention API
  #
  # @since 0.1.0
  class Configuration
    # @!attribute account_id
    #   @return [String] Mention Account ID
    # @!attribute access_token
    #   @return [String] Mention Application Access Token
    attr_accessor :account_id, :access_token

    # Initializes new NameDrop::Configuration object
    #
    # Sets default account_id and access_token
    def initialize
      @account_id = 'NotARealAccountID'
      @access_token = 'NotARealAccessToken'
    end
  end

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
end
