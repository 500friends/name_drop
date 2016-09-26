module NameDrop
  module Associations
    module Dsl
      extend ActiveSupport::Concern

      module ClassMethods
        def has_many(collection, options = {})
          HasMany.define_relation(self, collection, options)
        end

        def belongs_to(parent)
          BelongsTo.define_relation(parent, self)
        end
      end
    end
  end
end
