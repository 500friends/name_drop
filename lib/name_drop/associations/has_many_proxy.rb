module NameDrop
  module Associations
    class HasManyProxy
      def initialize(parent, target_class, collection = [])
        @parent = parent
        @target_class = target_class
        @collection = collection
      end

      def all
        target_class.all(parent.client, parent_key => parent.attributes["id"]).each do |child|
          child.send("#{parent_attribute_name}=", parent) if child.respond_to?("#{parent_attribute_name}=")
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
