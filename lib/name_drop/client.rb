require 'rest-client'

# Namespace for classes and modules that handle interaction with Mention API
# @since 0.1.0
module NameDrop
  # Class that encapsulates calls to Mention API
  # @since 0.1.0
  class Client
    BASE_URL = "https://web.mention.net/api/accounts"

    # @return [NameDrop::Resources::Alert]
    def alerts
      Resources::BaseFactory.new(self, 'Alert')
    end

    # @return [NameDrop::Resources::Mention]
    def mentions
      Resources::BaseFactory.new(self, 'Mention')
    end

    # @return [NameDrop::Resources::Share]
    def shares
      Resources::BaseFactory.new(self, 'Share')
    end

    # @param [String] endpoint
    def get(endpoint)
      request(:get, endpoint)
    end

    # @param [String] endpoint
    # @param [Hash] attributes
    def post(endpoint, attributes)
      request(:post, endpoint, attributes)
    end

    # @param [String] endpoint
    # @param [Hash] attributes
    def put(endpoint, attributes)
      request(:put, endpoint, attributes)
    end

    # @param [String] endpoint
    def delete(endpoint)
      request(:delete, endpoint)
    end

    private

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

    # @param [Symbol] method
    # @param [String] endpoint
    # @param [Hash] attributes
    # @return [Hash] API request Hash
    def create_request_hash(method, endpoint, attributes)
      request_hash = { method: method, url: request_url(endpoint), headers: headers }
      request_hash[:payload] = attributes.to_json unless attributes.empty?
      request_hash
    end

    # @param [Symbol] method
    # @return [String] error message
    def error_message(method)
      "Error #{error_verbs[method]} Mention Resource"
    end

    # @return [Hash] HTTP verbs and associated error verbs
    def error_verbs
      { get: 'retrieving', post: 'creating', put: 'updating', delete: 'deleting' }
    end

    # @return [Hash] headers HTTP request
    def headers
      @headers ||= { 'Content-Type' => 'application/json',
                     'Accept-Version' => '1.8',
                     'Authorization' => "Bearer #{NameDrop.configuration.access_token}" }
    end

    # @param [String] endpoint
    # @return [String] URL
    def request_url(endpoint)
      [
        BASE_URL,
        NameDrop.configuration.account_id,
        endpoint
      ].join("/")
    end
  end
end
