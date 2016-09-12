# Namespace for classes and modules that handle interaction with Mention API
# @since 0.1.0
module NameDrop
  # Namespace for classes and modules that encapsulate Mention Objects
  # @since 0.1.0
  module Resources
    # Base class for all Mention resources (alerts, mentions, shares)
    # @abstract
    # @since 0.1.0
    class Base
      # @!attribute [rw] attributes
      #   @return [Hash] object attributes
      attr_accessor :attributes

      # @!attribute [r] errors
      #   @return [Hash] object errors
      attr_reader :errors

      # @param [NameDrop::Client] client
      # @param [Hash] attributes
      def initialize(client, attributes = {})
        @client = client
        @attributes = attributes.with_indifferent_access
        @errors = []
      end

      # @param [NameDrop::Client] client
      # @param [Hash] params
      # @return [Array] resource objects
      def self.all(client, params = {})
        response = client.get(endpoint(params))
        response[response_key.pluralize].map do |attributes|
          new(client, attributes)
        end
      end

      # @param [NameDrop::Client] client
      # @option params [Number] id Mention Object Id
      # @return [NameDrop::Base]
      def self.find(client, id)
        response = client.get("#{endpoint}/#{id}")
        if response[response_key].present?
          new(client, response[response_key])
        else
          response
        end
      end

      # @param [NameDrop::Client] client
      # @param [Hash] attributes
      # @return [NameDrop::Base]
      def self.build(client, attributes = {})
        new(client, attributes)
      end

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

      # @param [Hash] params
      def destroy(params = {})
        client.delete("#{endpoint(params)}/#{attributes[:id]}")
      end

      # @return [String]
      def self.response_key
        name.demodulize.downcase
      end

      private

      # @!attribute [r] client
      #   @return [NameDrop::Client] object
      attr_reader :client

      # @see [NameDrop::Base.response_key]
      # @return [String]
      def response_key
        self.class.response_key
      end

      # @return [Symbol]
      def persistence_action
        new_record? ? :post : :put
      end

      # @return [Boolean]
      def new_record?
        !attributes[:id]
      end
    end
  end
end
