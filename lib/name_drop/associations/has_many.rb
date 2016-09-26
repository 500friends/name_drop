module NameDrop
  module Associations
    class HasMany
      def self.define_relation(parent, collection, options = {})
        class_name = options[:class_name] || "::NameDrop::Resources::#{collection.to_s.classify}"

        parent.class_eval <<-EOF, __FILE__, __LINE__
          def #{collection}
            @#{collection} ||= HasManyProxy.new(self, #{class_name})
          end
        EOF
      end
    end
  end
end
