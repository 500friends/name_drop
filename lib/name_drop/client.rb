require 'rest-client'

# Namespace for classes and modules that handle interaction with Mention API
#
# @since 0.1.0
module NameDrop
  # Class that encapsulates calls to Mention API
  #
  # @since 0.1.0
  class Client
    def initialize(*)
    end

    # @!group Resources

    # Allows access through client.alerts
    #
    # @return [NameDrop::Resources::Alert]
    # @example accessing alerts for client
    #   client = NameDrop::Client.new
    #   alerts = client.alerts.all
    def alerts
      Resources::BaseFactory.new(self, 'Alert')
    end

    # Allows access through client.mentions
    #
    # @return [NameDrop::Resources::Mention]
    # @example accessing mentions for client
    #   client = NameDrop::Client.new
    #   mentions = client.mentions.all
    def mentions
      Resources::BaseFactory.new(self, 'Mention')
    end

    # Allows access through client.shares
    #
    # @return [NameDrop::Resources::Share]
    # @example accessing shares for client
    #   client = NameDrop::Client.new
    #   shares = client.shares.all
    def shares
      Resources::BaseFactory.new(self, 'Share')
    end

    # @!endgroup
    # @!group HTTP Requests

    # Makes GET Request through RestClient::Request.execute
    #
    # @param [String] endpoint
    # @return [Hash] encapsulates Mention API response of GET request
    def get(endpoint)
      request(:get, endpoint)
    end

    # Makes POST Request through RestClient::Request.execute
    #
    # @param [String] endpoint
    # @param [Hash] attributes
    # @return [Hash] encapsulates Mention API response of POST request
    def post(endpoint, attributes)
      request(:post, endpoint, attributes)
    end

    # Makes PUT Request through RestClient::Request.execute
    #
    # @param [String] endpoint
    # @param [Hash] attributes
    # @return [Hash] encapsulates Mention API response of PUT request
    def put(endpoint, attributes)
      request(:put, endpoint, attributes)
    end

    # Makes DELETE Request through RestClient::Request.execute
    #
    # @param [String] endpoint
    # @return [Hash] encapsulates Mention API response of DELETE request
    def delete(endpoint)
      request(:delete, endpoint)
    end

    # @!endgroup

    private

    # Calls RestClient::Request.execute with request hash, then parses response with JSON unless response is empty
    #
    # @param [Symbol] method
    # @param [String] endpoint
    # @param [Hash] attributes
    # @return [Hash]
    # @raise [NameDrop::Error] Rescuing RestClient::ExceptionWithResponse
    def request(method, endpoint, attributes = {})
      response = RestClient::Request.execute(create_request_hash(method, endpoint, attributes))
      JSON.parse(response) unless response.empty?
    rescue RestClient::ExceptionWithResponse => err
      raise NameDrop::Error.new(error_message(method), JSON.parse(err.response).with_indifferent_access)
    end

    # Sets request hash for API including attributes if present
    #
    # @param [Symbol] method
    # @param [String] endpoint
    # @param [Hash] attributes
    # @return [Hash] API request Hash
    def create_request_hash(method, endpoint, attributes)
      request_hash = { method: method, url: request_url(endpoint), headers: headers }
      request_hash[:payload] = attributes.to_json unless attributes.empty?
      request_hash
    end

    # Sets error message
    #
    # @param [Symbol] method
    # @return [String] error message
    def error_message(method)
      "Error #{error_verbs[method]} Mention Resource"
    end

    # @return [Hash] HTTP verbs and associated error verbs
    def error_verbs
      { get: 'retrieving', post: 'creating', put: 'updating', delete: 'deleting' }
    end

    # Sets headers for HTTP request including Mention access_token
    #
    # @return [Hash] headers HTTP request
    def headers
      @headers ||= { 'Content-Type' => 'application/json',
                     'Accept-Version' => '1.8',
                     'Authorization' => "Bearer #{NameDrop.configuration.access_token}" }
    end

    # Builds URL string for Mention API Request including Mention account_id
    #
    # @param [String] endpoint
    # @return [String] URL
    def request_url(endpoint)
      "https://web.mention.net/api/accounts/#{NameDrop.configuration.account_id}/#{endpoint}"
    end
  end
end
