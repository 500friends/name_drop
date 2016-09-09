require 'active_support/inflector'
require 'active_support/concern'
require 'active_support/core_ext/object'
require 'active_support/core_ext/hash/indifferent_access'

module NameDrop

  class << self
    def resource_class(resource)
      NameDrop::Resources.const_get(resource.to_s.classify)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configuration=(config)
      @configuration = config
    end

    def configure
      yield(configuration)
    end
  end

  autoload :Version,       'name_drop/version'
  autoload :Configuration, 'name_drop/configuration'
  autoload :Client,        'name_drop/client'
  autoload :Error,         'name_drop/error'

  module Resources
    autoload :Base,        'name_drop/resources/base'
    autoload :BaseFactory, 'name_drop/resources/base_factory'

    autoload :Alert,       'name_drop/resources/alert'
    autoload :Mention,     'name_drop/resources/mention'
    autoload :Share,       'name_drop/resources/share'
  end

  module Associations
    autoload :Dsl,         'name_drop/associations/dsl'
    autoload :BelongsTo,   'name_drop/associations/belongs_to'
  end
end



# require 'name_drop/version'
# require 'name_drop/configuration'
# require 'name_drop/client'
# require 'name_drop/error'
#
# require 'name_drop/resources/base'
# require 'name_drop/resources/base_factory'
#
# require 'name_drop/resources/alert'
# require 'name_drop/resources/mention'
# require 'name_drop/resources/share'
#
# require 'name_drop/associations/dsl'
# require 'name_drop/associations/belongs_to'


