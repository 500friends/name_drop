# Namespace for classes and modules that handle interaction with Mention API
#
# @since 0.1.0
module NameDrop
  # Namespace for classes and modules that encapsulate Mention Objects
  #
  # @since 0.1.0
  module Resources
    # Ruby object that encapsulates Mention alerts; Inherits from Base
    #
    # @since 0.1.0
    class Alert < Base
      has_many :mentions
      has_many :shares

      # @raise [NotImplementedError] 'You cannot delete an Alert directly'
      def destroy
        raise NotImplementedError, 'You cannot delete an Alert directly'
      end
    end
  end
end
