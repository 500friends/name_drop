module NameDrop
  module Resources
    class Share < Base
      belongs_to :alert

      def self.find(_id)
        raise NotImplementedError, 'Single fetch share not supported'
      end

      def save
        raise NotImplementedError, 'Single fetch update not supported'
      end
    end
  end
end
