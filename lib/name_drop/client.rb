# Namespace for classes and modules that handle interaction with Mention API
#
# @since 0.1.0
module NameDrop
  # Class that encapsulates calls to Mention API
  #
  # @since 0.1.0
  class Client
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
    # @param [Hash] attributes
    #
    # @return [Hash] encapsulates Mention API response of GET request
    def get(endpoint, attributes = {})
      execute_request build_request(endpoint, 'Get', attributes)
    end

    # Makes POST Request through RestClient::Request.execute
    #
    # @param [String] endpoint
    # @param [Hash] attributes
    # @return [Hash] encapsulates Mention API response of POST request
    def post(endpoint, attributes)
      execute_request build_request_with_body(endpoint, 'Post', attributes)
    end

    # Makes PUT Request through RestClient::Request.execute
    #
    # @param [String] endpoint
    # @param [Hash] attributes
    # @return [Hash] encapsulates Mention API response of PUT request
    def put(endpoint, attributes)
      execute_request build_request_with_body(endpoint, 'Put', attributes)
    end

    # Makes DELETE Request through RestClient::Request.execute
    #
    # @param [String] endpoint
    # @return [Hash] encapsulates Mention API response of DELETE request
    def delete(endpoint)
      execute_request build_request(endpoint, 'Delete')
    end

    # @!endgroup

    private

    def build_request(endpoint, method, attributes = {})
      uri = request_uri(endpoint)
      uri.query = URI.encode_www_form(attributes) if attributes.present?
      "Net::HTTP::#{method}".constantize.new uri
    end

    def build_request_with_body(endpoint, method, attributes = {})
      request = "Net::HTTP::#{method}".constantize.new request_uri(endpoint)
      request.body = JSON.dump(attributes) if attributes.any?
      request
    end

    def execute_request(request)
      response = Net::HTTP.start(request.uri.hostname, request.uri.port, use_ssl: true) { |http| http.request(add_headers(request)) }
      json_response = safe_json_parse(response.body)
      case response
      when Net::HTTPSuccess
        json_response
      else
        raise NameDrop::Error.new(error_message(request.method), json_response)
      end
    end

    def safe_json_parse(json)
      JSON.parse(json).with_indifferent_access
    rescue
      json
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
      {
        'GET' => 'retrieving',
        'POST' => 'creating',
        'PUT' => 'updating',
        'DELETE' => 'deleting'
      }
    end

    # Add HTTP headers to the request including Mention access_token
    #
    # @return [Net::HTTP::Get, Net::HTTP::Put, Net::HTTP::Post, Net::HTTP::Delete] HTTP request object
    def add_headers(request)
      request.content_type = 'application/json'
      request.add_field 'Accept-Version', '1.8'
      request.add_field 'Authorization', "Bearer #{NameDrop.configuration.access_token}"
      request
    end

    # Builds URL string for Mention API Request including Mention account_id
    #
    # @param [String] endpoint
    # @return [URI] The URI for the Mention resource
    def request_uri(endpoint)
      URI("https://web.mention.net/api/accounts/#{NameDrop.configuration.account_id}/#{endpoint}")
    end
  end
end
