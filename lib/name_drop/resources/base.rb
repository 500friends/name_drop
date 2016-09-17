# Namespace for classes and modules that handle interaction with Mention API
#
# @since 0.1.0
module NameDrop
  # Namespace for classes and modules that encapsulate Mention Objects
  #
  # @since 0.1.0
  module Resources
    # Base class for all Mention resources (alerts, mentions, shares)
    #
    # @abstract
    # @since 0.1.0
    class Base
      # @!attribute [rw] attributes
      #   @return [Hash] object attributes
      attr_accessor :attributes

      # Returns a hash of errors associated with the object, defined by the response from Mention API
      #
      # @!attribute [r] errors
      #   @return [Hash] object errors
      attr_reader :errors

      # Initializes new NameDrop::Resources::Base object
      # Sets client, adds indifferent access to attributes, sets errors to empty array
      #
      # @param [NameDrop::Client] client
      # @param [Hash] attributes
      def initialize(client, attributes = {})
        @client = client
        @attributes = attributes.with_indifferent_access
        @errors = []
      end

      # Sends client url to get, and parses response into array of ruby objects of resource type
      # Returns an array for ruby object records of a given resource type (alert, mention, share)
      #
      # @param [NameDrop::Client] client
      # @param [Hash] params
      # @return [Array] resource objects
      def self.all(client, params = {})
        response = client.get(endpoint(params))
        response[response_key.pluralize].map do |attributes|
          new(client, attributes)
        end
      end

      # Sends client url to get, and parses response to ruby objects of resource type
      # Returns a ruby object specific record for requested resource, found by Mention API id
      #
      # @param [NameDrop::Client] client
      # @option params [Number] id Mention Object Id
      # @return [NameDrop::Resources::Base]
      def self.find(client, id)
        response = client.get("#{endpoint}/#{id}")
        if response[response_key].present?
          new(client, response[response_key])
        else
          response
        end
      rescue NameDrop::Error => error
        return if error.detail['code'] == 404
        raise error
      end

      # Builds a new ruby object to encapsulate resource
      #
      # @param [NameDrop::Client] client
      # @param [Hash] attributes
      # @return [NameDrop::Resources::Base]
      def self.build(client, attributes = {})
        new(client, attributes)
      end

      # Sends persistence_action, url and attributes to client and parses response onto ruby objects
      # Uses ruby resource attributes to create or update objects through Mention API request via NameDrop::Client
      #
      # @return [Boolean]
      def save
        path = new_record? ? endpoint : "#{endpoint}/#{attributes[:id]}"
        response = client.send(persistence_action, path, attributes)
        if response[response_key].present?
          self.attributes = response[response_key]
          true
        else
          @errors = response
          false
        end
      end

      # Makes destroy request via NameDrop::Client
      #
      # @param [Hash] params
      def destroy(params = {})
        client.delete("#{endpoint(params)}/#{attributes[:id]}")
      end

      # Returns name of Mention API object
      #
      # @return [String]
      def self.response_key
        name.demodulize.downcase
      end

      private

      # @!attribute [r] client
      #   @return [NameDrop::Client] object
      attr_reader :client

      # Returns name of Mention API object
      #
      # @see [NameDrop::Resources::Base.response_key]
      # @return [String]
      def response_key
        self.class.response_key
      end

      # Returns HTTP method new records -> :post, existing records -> :put
      #
      # @return [Symbol]
      def persistence_action
        new_record? ? :post : :put
      end

      # Determines whether object is a new_record, which is true if :id key is missing
      #
      # @return [Boolean]
      def new_record?
        !attributes[:id]
      end
    end
  end
end
