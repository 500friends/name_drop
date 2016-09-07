module NameDrop
  class Error < StandardError
    attr_reader :detail

    def initialize(msg, detail)
      @detail = detail
      super msg
    end
  end
end
