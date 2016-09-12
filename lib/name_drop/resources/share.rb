# Namespace for classes and modules that handle interaction with Mention API
# @since 0.1.0
module NameDrop
  # Namespace for classes and modules that encapsulate Mention Objects
  # @since 0.1.0
  module Resources
    # Ruby object that encapsulates Mention shares of alert; Inherits from Base
    # @since 0.1.0
    class Share < Base
      # @param [String] _id (unused) for Shares inherited from Base
      # @raise [NotImplementedError] 'Single fetch share not supported'
      def self.find(_id)
        raise NotImplementedError, 'Single fetch share not supported'
      end

      # @raise [NotImplementedError] 'Single fetch share not supported'
      def save
        raise NotImplementedError, 'Single fetch update not supported'
      end

      # @see NameDrop::Share.endpoint
      # @param [Hash] params the options to return an endpoint with
      # @option params [Number] alert_id Mention Alert Id
      # @return [String] string containing Mention API Endpoint
      def endpoint(params = {})
        self.class.endpoint(params)
      end

      # @param [Hash] params the options to return an endpoint with
      # @option params [Number] alert_id Mention Alert Id
      # @return [String] string containing Mention API Endpoint
      def self.endpoint(params = {})
        "alerts/#{params[:alert_id]}/shares"
      end
    end
  end
end
