module NameDrop
  module Associations
    class BelongsTo
      def self.relationships
        @_relationships ||= {}
      end

      def self.define_relation(parent, child)
        relationships[child] ||= []
        relationships[child].push(parent)
      end
    end
  end
end
