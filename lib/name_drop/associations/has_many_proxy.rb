module NameDrop
  module Associations
    class HasManyProxy
      def initialize(parent, target_class)
        @parent = parent
        @target_class = target_class
      end

      def all
        @all ||= target_class.all(parent.client, parent_key => parent.attributes["id"]).each do |child|
          child.send("#{parent_attribute_name}=", parent) if child.respond_to?("#{parent_attribute_name}=")
        end
      end

      def build(attributes = {})
        target_class.new(parent.client, attributes.merge(parent_key => parent.attributes["id"]))
      end

      def reload
        @all = nil
        all
      end

      def method_missing(method, *args, &block)
        if all.respond_to?(method)
          all.send(method, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(method, *args, &block)
        if all.respond_to?(method)
          true
        else
          super
        end
      end

      private

      attr_reader :parent, :target_class, :collection

      def parent_key
        [parent_attribute_name, "id"].join("_").to_sym
      end

      def parent_attribute_name
        parent.class.name.demodulize.downcase
      end
    end
  end
end
