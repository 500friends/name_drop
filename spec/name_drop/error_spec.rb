require 'spec_helper'

describe NameDrop::Error do
  subject(:error) { described_class.new("These aren't the", 'Droids were looking for') }

  describe '#initialize' do
    it 'sets the message' do
      expect(error.message).to eq("These aren't the")
    end

    it 'sets the detail' do
      error = described_class.new('You will take me', 'to Jobba now')
      expect(error.detail).to eq('to Jobba now')
    end
  end

  describe '#to_s' do
    it 'returns the message for the exception' do
      expect(subject.to_s).to eq "These aren't the"
    end

    context 'when -verbose- configuration option is enabled' do
      before(:each) { NameDrop.configuration.verbose = true }
      after(:each) { NameDrop.configuration.verbose = false }

      it 'returns the message and detail for the exception' do
        expect(subject.to_s).to eq "These aren't the\nDroids were looking for"
      end
    end
  end
end
