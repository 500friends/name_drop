require 'rails/railtie'

module NameDrop
  class Railtie < Rails::Railtie
    config.eager_load_namespaces << NameDrop
  end
end
