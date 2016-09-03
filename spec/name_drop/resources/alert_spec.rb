require 'spec_helper'

describe NameDrop::Resources::Alert do
  let(:client) { NameDrop::Client.new }
  let(:alert) { NameDrop::Resources::Alert.new(client) }

  describe '#all' do
  end

  describe '#find' do
  end

  describe '#save' do
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
