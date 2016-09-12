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
end
