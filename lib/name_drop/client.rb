require 'rest-client'

module NameDrop
  class Client
    def initialize(*)
    end

    def alerts
      Resources::BaseFactory.new(self, 'Alert')
    end

    def mentions
      Resources::BaseFactory.new(self, 'Mention')
    end

    def shares
      Resources::BaseFactory.new(self, 'Share')
    end

    def get(endpoint)
      request(:get, endpoint)
    end

    def post(endpoint, attributes)
      request(:post, endpoint, attributes)
    end

    def put(endpoint, attributes)
      request(:put, endpoint, attributes)
    end

    def delete(endpoint)
      request(:delete, endpoint)
    end

    private

    def request(method, endpoint, attributes = {})
      response = RestClient::Request.execute(create_request_hash(method, endpoint, attributes))
      JSON.parse(response) unless response.empty?
    rescue RestClient::ExceptionWithResponse => err
      raise NameDrop::Error.new(error_message(method), JSON.parse(err.response))
    end

    def create_request_hash(method, endpoint, attributes)
      request_hash = { method: method, url: request_url(endpoint), headers: headers }
      request_hash[:payload] = attributes.to_json unless attributes.empty?
      request_hash
    end

    def error_message(method)
      "Error #{error_verbs[method]} Mention Resource"
    end

    def error_verbs
      { get: 'retrieving', post: 'creating', put: 'updating', delete: 'deleting' }
    end

    def headers
      @headers ||= { 'Content-Type' => 'application/json',
                     'Accept-Version' => '1.8',
                     'Authorization' => "Bearer #{NameDrop.configuration.access_token}" }
    end

    def request_url(endpoint)
      "https://web.mention.net/api/accounts/#{NameDrop.configuration.account_id}/#{endpoint}"
    end
  end
end
