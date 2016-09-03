module NameDrop
  module Resources
    class Share < Base
      def self.find(_id)
        raise NotImplementedError, 'Single fetch share not supported'
      end

      def save
        raise NotImplementedError, 'Single fetch update not supported'
      end

      def self.endpoint(params = {})
        "alerts/#{params[:alert_id]}/shares"
      end

      def endpoint(params = {})
        self.class.endpoint(params)
      end
    end
  end
end
