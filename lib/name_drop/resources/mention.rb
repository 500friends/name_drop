module NameDrop
  module Resources
    class Mention < Base
      def self.find(_id)
        raise NotImplementedError, 'Single fetch mention not supported'
      end

      def save
        raise NotImplementedError, 'You cannot alter a mention'
      end

      def destroy
        raise NotImplementedError, 'You cannot alter a mention'
      end

      def self.endpoint(params = {})
        "alerts/#{params[:alert_id]}/mentions"
      end
    end
  end
end
