require 'spec_helper'

describe NameDrop::Resources::Mention do
  let(:client) { NameDrop::Client.new }
  let(:mention) { NameDrop::Resources::Mention.new(client) }

  describe '#all' do
    it 'calls get on client' do
      expect(client).to receive(:get).with('alerts/1/mentions').and_return('mentions' => [{ 'a' => 'b' }, { 'c' => 'd' }])
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
end
