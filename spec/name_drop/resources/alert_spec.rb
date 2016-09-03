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

  describe '#build' do
    it 'returns a new record' do
      alert = NameDrop::Resources::Alert.build(client, { 'hmm' => 'there' })
      expect(alert.class).to eq(NameDrop::Resources::Alert)
    end
  end

  describe '#save' do
    shared_examples_for '#save' do
      let(:response) { { 'yo' => 'ho ho' } }

      it 'sends action to client' do
        expect(client).to receive(:send).with(action, anything, anything).and_return(response)
        alert.save
      end

      it 'sends path to client' do
        expect(client).to receive(:send).with(anything, end_point, anything).and_return(response)
        alert.save
      end

      it 'sends attr hash to client' do
        expect(client).to receive(:send).with(anything, anything, attr).and_return(response)
        alert.save
      end

      context '#save response with errors' do
        let(:response) { { 'bottle' => 'of rum' } }

        it 'sets alert.errors to response' do
          expect(client).to receive(:send).with(any_args).and_return(response)
          alert.save
          expect(alert.errors).to eq(response)
        end

        it 'returns false' do
          expect(client).to receive(:send).with(any_args).and_return(response)
          expect(alert.save).to eq false
        end
      end

      context '#save response without errors' do
        let(:alert_content) { { 'oh' => 'nose' } }
        let(:response) { { 'alert' => alert_content } }

        it 'does not set errors' do
          expect(client).to receive(:send).with(any_args).and_return(response)
          alert.save
          expect(alert.errors).to eq([])
        end

        it 'sets alert.attributes to response' do
          expect(client).to receive(:send).with(any_args).and_return(response)
          alert.save
          expect(alert.attributes).to eq(alert_content)
        end

        it 'returns false' do
          expect(client).to receive(:send).with(any_args).and_return(response)
          expect(alert.save).to eq true
        end
      end
    end

    context 'new record' do
      let(:action) { :post }
      let(:end_point) { 'alerts' }
      let(:attr) { { whoa: 'neo' } }
      let(:alert) { NameDrop::Resources::Alert.build(client, attr) }

      it_should_behave_like '#save'
    end

    context 'existing record' do
      let(:action) { :put }
      let(:end_point) { 'alerts/8' }
      let(:attr) { { 'id' => '8', 'hmm' => 'there' } }
      let(:alert) { NameDrop::Resources::Alert.build(client, attr) }

      it_should_behave_like '#save'
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
