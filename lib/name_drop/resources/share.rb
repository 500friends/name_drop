# Namespace for classes and modules that handle interaction with Mention API
# @since 0.1.0
module NameDrop
  # Namespace for classes and modules that encapsulate Mention Objects
  # @since 0.1.0
  module Resources
    # Ruby object that encapsulates Mention shares of alert; Inherits from Base
    # @since 0.1.0
    class Share < Base
      belongs_to :alert

      # @param [String] _id (unused) for Shares inherited from Base
      # @raise [NotImplementedError] 'Single fetch share not supported'
      def self.find(_id)
        raise NotImplementedError, 'Single fetch share not supported'
      end

      # @raise [NotImplementedError] 'Single fetch share not supported'
      def save
        raise NotImplementedError, 'Single fetch update not supported'
      end
    end
  end
end
