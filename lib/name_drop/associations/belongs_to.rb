module NameDrop
  module Associations
    class BelongsTo
      def self.relationships
        @_relationships ||= {}
      end

      def self.define_relation(parent, child)
        relationships[child.name] ||= []
        relationships[child.name].push(parent)

        key = "#{parent}_id"

        child.class_eval <<-EOF, __FILE__, __LINE__
          def #{key}
            attributes[#{key}]
          end
        EOF

        child.class_eval <<-EOF, __FILE__, __LINE__
          attr_writer :#{parent}

          def #{parent}
            unless instance_variable_defined?("@#{parent}")
              @#{parent}= ::NameDrop.resource_class(#{parent}).find(client, attributes[#{key}])
            end

            @#{parent}
          end
        EOF
      end
    end
  end
end
