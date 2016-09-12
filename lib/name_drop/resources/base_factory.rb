# Namespace for classes and modules that handle interaction with Mention API
#
# @since 0.1.0
module NameDrop
  # Namespace for classes and modules that encapsulate Mention Objects
  #
  # @since 0.1.0
  module Resources
    # Class using factory pattern to pass client to resources
    #
    # @since 0.1.0
    class BaseFactory
      # Initializes new NameDrop::Resources::BaseFactory object
      # Sets client, resource_class_name
      #
      # @param [NameDrop::Client] client
      # @param [String] resource_class_name
      def initialize(client, resource_class_name)
        @client = client
        @resource_class_name = resource_class_name
      end

      # Sends methods to Resource Class with client with any arguments
      #
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

      # Constantize full class name to allow methods to be sent to class
      #
      # @return [Class] Returns Resource Class
      def modularized_class
        "NameDrop::Resources::#{resource_class_name}".constantize
      end
    end
  end
end
