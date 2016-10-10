require 'spec_helper'

describe NameDrop::Resources::Share do
  let(:client) { NameDrop::Client.new }
  let(:share) { NameDrop::Resources::Share.new(client, 'id' => 8) }

  describe '#all' do
    it 'calls get on client' do
      expect(client).to receive(:get).with('alerts/1/shares', {}).and_return('shares' => [{ 'a' => 'b' }, { 'c' => 'd' }])
      NameDrop::Resources::Share.all(client, alert_id: 1)
    end
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
    it 'sends client delete with appropriate endpoint' do
      expect(client).to receive(:delete).with('alerts/5/shares/8')
      share.destroy(alert_id: 5)
    end
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
