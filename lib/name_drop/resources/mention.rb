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

      # @note The default page size for children is 20, although up to 100 can be returned
      #   by specifying limit: 100. The Mention API also returns paging data so we can support
      #   pagination in the future if the need arises.
      # @return [Array] Collection of child mentions
      def children(params = {})
        endpoint = "#{self.class.endpoint(alert_id: attributes[:alert_id])}/#{attributes[:id]}/children"

        response = client.get(endpoint, params)
        response["children"].map do |attributes|
          self.class.new(client, attributes)
        end
      end

      # Sets suffix of Mention API call
      #
      # @param [Hash] params the options to return an endpoint with
      # @option params [Integer] :alert_id Mention Alert Id
      # @return [String] string containing Mention API Endpoint
      def self.endpoint(params = {})
        "alerts/#{params[:alert_id]}/mentions"
      end
    end
  end
end
