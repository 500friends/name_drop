require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext/object'

module NameDrop
  module Resources
    class BaseFactory
      def initialize(client, resource_class_name)
        @client = client
        @resource_class_name = resource_class_name
      end

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

      attr_reader :client, :resource_class_name

      def modularized_class
        "NameDrop::Resources::#{resource_class_name}".constantize
      end
    end
  end
end
