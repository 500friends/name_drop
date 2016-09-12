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
      # @raise [NotImplementedError] 'You cannot delete an Alert directly'
      def destroy
        raise NotImplementedError, 'You cannot delete an Alert directly'
      end

      # Sets suffix of Mention API call
      #
      # @see NameDrop::Resources::Alert.endpoint
      # @return [String] 'alerts'
      def endpoint
        self.class.endpoint
      end

      # Sets suffix of Mention API call
      #
      # @param [Hash] _params (unused) for Alerts inherited from Base
      # @return [String] 'alerts'
      def self.endpoint(_params = {})
        'alerts'
      end
    end
  end
end
