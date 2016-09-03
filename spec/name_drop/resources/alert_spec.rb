require 'spec_helper'

describe NameDrop::Resources::Alert do
  let(:client) { NameDrop::Client.new }
  let(:alert) { NameDrop::Resources::Alert.new(client) }

  describe '#all' do
    it 'calls get on client' do
      expect(client).to receive(:get).with('alerts').and_return('alerts' => %w(a b))
      NameDrop::Resources::Alert.all(client)
    end
  end


  describe '#find' do
    it 'calls get on client' do
      expect(client).to receive(:get).with('alerts/8').and_return('alert' => { 'a' => 'b' })
      NameDrop::Resources::Alert.find(client, 8)
    end

    context 'response_key found in reply' do
      it 'return an alert record' do
        allow(client).to receive(:get).with('alerts/8').and_return('alert' => { 'a' => 'b' })
        result = NameDrop::Resources::Alert.find(client, 8)
        expect(result.class).to eq(NameDrop::Resources::Alert)
      end
    end

    context 'response_key not found in reply' do
      it 'return response not an alert record' do
        allow(client).to receive(:get).with('alerts/8').and_return('siren' => { 'a' => 'b' })
        result = NameDrop::Resources::Alert.find(client, 8)
        expect(result.class).to eq(Hash)
      end
    end
  end

  describe '#save' do
    context 'new record' do

    end

    context 'existing record' do

    end
  end

  describe '#destroy' do
    it 'raises a Not Implemented error' do
      expect {
        alert.destroy
      }.to raise_error(NotImplementedError)
    end
  end

  describe '.endpoint' do
    it 'returns alerts' do
      expect(NameDrop::Resources::Alert.endpoint).to eq('alerts')
    end
  end

  describe '#endpoint' do
    it 'returns alerts' do
      expect(alert.endpoint).to eq('alerts')
    end
  end
end
