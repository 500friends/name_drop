module NameDrop
  module Resources
    class Mention < Base
      belongs_to :alert

      def self.find(_id)
        raise NotImplementedError, 'Single fetch mention not supported'
      end

      def save
        raise NotImplementedError, 'You cannot alter a mention'
      end

      def destroy
        raise NotImplementedError, 'You cannot alter a mention'
      end
    end
  end
end
