module NameDrop
  module Associations
    module Dsl
      extend ActiveSupport::Concern

      module ClassMethods
        def has_many(collection, options = {})
          class_name = options[:class_name] || "::NameDrop::Resources::#{collection.to_s.classify}"
          self_key = "#{self.name.demodulize.downcase}_id".to_sym

          define_method collection do
            class_name.constantize.all(client, self_key => attributes["id"])
          end
        end

        def belongs_to(parent)
          BelongsTo.define_relation(parent, self)

          key = "#{parent}_id"

          define_method key do
            attributes[key]
          end

          define_method parent do
            unless instance_variable_defined?("@_#{parent}")
              instance_variable_set("@_#{parent}", ::NameDrop.resource_class(parent).find(client, attributes[key]))
            end

            instance_variable_get("@_#{parent}")
          end
        end
      end
    end
  end
end
