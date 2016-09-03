require 'name_drop/version'

module NameDrop
  class << self
    attr_reader :config

    def config=(config)
      @config ||= Struct.new(*config.keys).new(*config.values)
    end
  end
end
