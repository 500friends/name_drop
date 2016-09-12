# Namespace for classes and modules that handle interaction with Mention API
#
# @since 0.1.0
module NameDrop
  # Namespace for classes and modules that encapsulate Mention Objects
  #
  # @since 0.1.0
  module Resources
    # Ruby object that encapsulates Mention mentions; Inherits from Base
    #
    # @since 0.1.0
    class Mention < Base
      belongs_to :alert

      # @param [String] _id (unused) for Mentions inherited from Base
      # @raise [NotImplementedError] 'Single fetch mention not currently supported'
      def self.find(_id)
        raise NotImplementedError, 'Single fetch mention not currently supported'
      end

      # @raise [NotImplementedError] 'You cannot alter a mention'
      def save
        raise NotImplementedError, 'You cannot alter a mention'
      end

      # @raise [NotImplementedError] 'You cannot alter a mention'
      def destroy
        raise NotImplementedError, 'You cannot alter a mention'
      end
    end
  end
end
