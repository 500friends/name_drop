# Namespace for classes and modules that handle interaction with Mention API
# @since 0.1.0
module NameDrop
  class Error < StandardError
    # @!attribute [r] detail
    #   @return [#detail] Error Detail
    attr_reader :detail

    # Initializes new NameDrop::Error object
    # @param msg [string] Contains Error Message
    # @param detail [#detail] Contains Error Details
    def initialize(msg, detail)
      @detail = detail
      super msg
    end
  end
end
