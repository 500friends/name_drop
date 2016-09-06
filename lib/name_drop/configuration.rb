module NameDrop
  class Configuration
    attr_accessor :account_id, :access_token

    def initialize
      @account_id = 'NotARealAccountID'
      @access_token = 'NotARealAccessToken'
    end
  end
end
