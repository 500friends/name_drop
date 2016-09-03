require 'spec_helper'

describe NameDrop::Resources::Mention do
  let(:client) { NameDrop::Client.new }
  let(:mention) { NameDrop::Resources::Mention.new(client) }

  describe '#all' do
    it 'calls get on client' do
      expect(client).to receive(:get).with('alerts/1/mentions').and_return({ 'mentions' => %w(a b) })
      NameDrop::Resources::Mention.all(client, alert_id: 1)
    end
  end

  describe '#find' do
    it 'raises a Not Implemented error' do
      expect {
        NameDrop::Resources::Mention.find(1)
      }.to raise_error(NotImplementedError)
    end
  end

  describe '#save' do
    it 'raises a Not Implemented error' do
      expect {
        mention.save
      }.to raise_error(NotImplementedError)
    end
  end

  describe '#destroy' do
    it 'raises a Not Implemented error' do
      expect {
        mention.destroy
      }.to raise_error(NotImplementedError)
    end
  end

  describe '.endpoint' do
    it 'returns alerts/:alert_id/mentions' do
      expect(NameDrop::Resources::Mention.endpoint(alert_id: 1)).to eq('alerts/1/mentions')
    end
  end
end
