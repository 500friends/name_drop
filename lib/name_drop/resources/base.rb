module NameDrop
  module Resources
    class Base
      include ::NameDrop::Associations::Dsl

      attr_accessor :attributes
      attr_reader :client, :errors

      def initialize(client, attributes = {})
        @client = client
        @attributes = attributes.with_indifferent_access
        @errors = []
      end

      def self.all(client, params = {})
        response = client.get(path(params: params))
        response[response_key.pluralize].map do |attributes|
          new(client, attributes)
        end
      end

      def self.find(client, id, parmas = {})
        response = client.get(path(type: :singular, params: { id: id }))

        if response[response_key].present?
          new(client, response[response_key])
        else
          response
        end
      end

      def self.build_nested_prefix(attributes)
        attributes = attributes.with_indifferent_access
        belongs_to_relationships = ::NameDrop::Associations::BelongsTo.relationships[self.name]
        prefix = ""
        return prefix unless belongs_to_relationships.present?

        belongs_to_relationships.inject(prefix) { |pref_so_far, rel|
          pref_so_far.to_s + rel.to_s.pluralize + "/" + attributes["#{rel}_id"].to_s + "/"
        }
      end

      def self.path(params: {}, type: nil, prefix: nil, new_record: false)
        params = params.with_indifferent_access

        prefix = prefix || build_nested_prefix(params)
        resource_name = self.name.demodulize.downcase.pluralize
        endpoint = prefix + resource_name

        if type == :singular
          endpoint + params["id"]
        elsif type == :persistence
          if new_record
            endpoint
          else
            endpoint + "/" + params["id"]
          end
        else
          endpoint
        end
      end

      def path(type:)
        self.class.path(
          type: type,
          params: attributes,
          prefix: self.class.build_nested_prefix(attributes),
          new_record: new_record?
        )
      end

      def self.build(client, attributes = {})
        new(client, attributes)
      end

      def save
        response = client.send(persistence_action, path(type: :persistence), attributes)

        if response[response_key].present?
          self.attributes = response[response_key]
          true
        else
          @errors = response
          false
        end
      end

      def destroy(params = {})
        client.delete(path(type: :singular))
      end

      def self.response_key
        name.demodulize.downcase
      end

      private

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
