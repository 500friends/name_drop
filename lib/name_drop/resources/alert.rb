module NameDrop
  module Resources
    class Alert < Base
      has_many :mentions
      has_many :shares

      def destroy
        raise NotImplementedError, 'You cannot delete an Alert directly'
      end
    end
  end
end
