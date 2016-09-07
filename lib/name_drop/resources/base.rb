require 'active_support/inflector'
require 'active_support/core_ext/object'
require 'active_support/core_ext/hash/indifferent_access'

module NameDrop
  module Resources
    class Base
      attr_accessor :attributes
      attr_reader :errors

      def initialize(client, attributes = {})
        @client = client
        @attributes = attributes.with_indifferent_access
        @errors = []
      end

      def self.all(client, params = {})
        response = client.get(endpoint(params))
        response[response_key.pluralize].map do |attributes|
          new(client, attributes)
        end
      end

      def self.find(client, id)
        response = client.get("#{endpoint}/#{id}")
        if response[response_key].present?
          new(client, response[response_key])
        else
          response
        end
      end

      def self.build(client, attributes = {})
        new(client, attributes)
      end

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

      def destroy(params = {})
        client.delete("#{endpoint(params)}/#{attributes[:id]}")
      end

      def self.response_key
        name.demodulize.downcase
      end

      private

      attr_reader :client

      def response_key
        self.class.response_key
      end

      def persistence_action
        new_record? ? :post : :put
      end

      def new_record?
        !attributes[:id]
      end
    end
  end
end
