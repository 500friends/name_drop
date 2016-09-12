module NameDrop
  module Resources
    class Alert < Base
      has_many :mentions
      has_many :shares

      def destroy
        raise NotImplementedError, 'You cannot delete an Alert directly'
      end

      def endpoint
        self.class.endpoint
      end

      def self.endpoint(_params = {})
        'alerts'
      end
    end
  end
end
