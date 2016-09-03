require 'spec_helper'

describe NameDrop::Resources::Share do
  let(:client) { NameDrop::Client.new }
  let(:share) { NameDrop::Resources::Share.new(client) }

  describe '#all' do
  end

  describe '#find' do
    it 'raises a Not Implemented error' do
      expect {
        NameDrop::Resources::Share.find(1)
      }.to raise_error(NotImplementedError)
    end
  end

  describe '#save' do
    it 'raises a Not Implemented error' do
      expect {
        share.save
      }.to raise_error(NotImplementedError)
    end
  end

  describe '#destroy' do
  end

  describe '.endpoint' do
    it 'returns alerts/:alert_id/shares' do
      expect(NameDrop::Resources::Share.endpoint(alert_id: 2)).to eq('alerts/2/shares')
    end
  end

  describe '#endpoint' do
    it 'returns alerts/:alert_id/shares' do
      expect(share.endpoint(alert_id: 3)).to eq('alerts/3/shares')
    end
  end
end
