require 'spec_helper'

describe NameDrop::Resources::Share do
  let(:client) { NameDrop::Client.new }
  let(:share) { NameDrop::Resources::Share.new(client, 'id' => 8, 'alert_id' => 5) }

  describe '#all' do
    it 'calls get on client' do
      expect(client).to receive(:get).with('alerts/1/shares').and_return('shares' => [{ 'a' => 'b' }, { 'c' => 'd' }])
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
      share.destroy
    end
  end
end
