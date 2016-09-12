# Namespace for classes and modules that handle interaction with Mention API
# @since 0.1.0
module NameDrop
  # Namespace for classes and modules that encapsulate Mention Objects
  # @since 0.1.0
  module Resources
    # Class using factory pattern
    class BaseFactory
      # @param [NameDrop::Client] client
      # @param [String] resource_class_name
      def initialize(client, resource_class_name)
        @client = client
        @resource_class_name = resource_class_name
      end

      # @param [Array] methods
      def self.delegate_to_target(*methods)
        methods.each do |method|
          define_method method do |*args|
            modularized_class.send(method, client, *args)
          end
        end
      end
      private_class_method :delegate_to_target

      delegate_to_target :all, :find, :build

      private

      # @!attribute [r] client
      #   @return [NameDrop::Client] object
      attr_reader :client

      # @!attribute [r] resource_class_name
      #   @return [String]
      attr_reader :resource_class_name

      # @return [Class] Returns Resource Class
      def modularized_class
        "NameDrop::Resources::#{resource_class_name}".constantize
      end
    end
  end
end
