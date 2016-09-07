require 'spec_helper'

describe NameDrop::Error do
  describe '#initialize' do
    it 'sets the message' do
      error = NameDrop::Error.new('These arent the', 'Droids were looking for')
      expect(error.message).to eq('These arent the')
    end

    it 'sets the detail
' do
      error = NameDrop::Error.new('You will take me', 'to Jobba now')
      expect(error.detail).to eq('to Jobba now')
    end
  end
end
