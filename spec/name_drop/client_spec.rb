require 'spec_helper'

describe NameDrop::Client do
  describe '#initialize' do
    it 'allows a new client to be instantiated' do
      expect{
        NameDrop::Client.new
      }.to_not raise_error
    end
  end

  let(:client) { client = NameDrop::Client.new }
  let(:json) { { order: 'Royale with cheese' }.to_json }
  let(:headers) { { 'Content-Type' => 'application/json',
                    'Accept-Version' => '1.8',
                    'Authorization' => 'Bearer NotARealAccessToken' } }

  describe '#alerts' do
    it 'sends self and Alert to BaseFactory.new' do
      expect(NameDrop::Resources::BaseFactory).to receive(:new).with(client, 'Alert').and_call_original
      client.alerts
    end
  end

  describe '#mentions' do
    it 'sends self and Mention to Resources::BaseFactory.new' do
      expect(NameDrop::Resources::BaseFactory).to receive(:new).with(client, 'Mention').and_call_original
      client.mentions
    end
  end

  describe '#shares' do
    it 'sends self and Share to Resources::BaseFactory.new' do
      expect(NameDrop::Resources::BaseFactory).to receive(:new).with(client, 'Share').and_call_original
      client.shares
    end
  end

  shared_examples_for 'a request' do
    it 'sends the method in a hash to RestClient' do
      expect(RestClient::Request).to receive(:execute).with(hash_including(method: method)).and_return(json)
      client.send(method, *arguments)
    end

    it 'sets the url based on endpoint and account_id' do
      mention_url = "https://web.mention.net/api/accounts/NotARealAccountID/#{endpoint}"
      expect(RestClient::Request).to receive(:execute).with(hash_including(url: mention_url)).and_return(json)
      client.send(method, *arguments)
    end

    it 'sets the headers for the request' do
      expect(RestClient::Request).to receive(:execute).with(hash_including(headers: headers)).and_return(json)
      client.send(method, *arguments)
    end

    context 'request throws an error' do
      it 'raises NameDrop::Error with correct message' do
        error = RestClient::ExceptionWithResponse.new({code: 400}.to_json)
        allow(RestClient::Request).to receive(:execute).and_raise(error)
        error_message = "Error #{error_verb} Mention Resource"
        expect {
          client.send(method, *arguments)
        }.to raise_error(NameDrop::Error, error_message)
      end
    end
  end

  shared_examples_for 'a request without attributes' do
    it 'does not send a payload with the request' do
      expect(RestClient::Request).to receive(:execute).with(hash_excluding(payload: anything)).and_return(json)
      client.send(method, endpoint)
    end
  end

  shared_examples_for 'a request with attributes' do
    it 'sends a payload with the request' do
      expect(RestClient::Request).to receive(:execute).with(hash_including(payload: attributes.to_json)).and_return(json)
      client.send(method, endpoint, attributes)
    end
  end

  describe '#get' do
    let(:method) { :get }
    let(:error_verb) { 'retrieving' }
    let(:endpoint) { 'alerts' }
    let(:arguments) { [endpoint] }
    it_should_behave_like 'a request'
    it_should_behave_like 'a request without attributes'
  end

  describe '#post' do
    let(:method) { :post }
    let(:error_verb) { 'creating' }
    let(:endpoint) { 'alerts' }
    let(:attributes) { { your_mom: 'is so' } }
    let(:arguments) { [endpoint, attributes] }
    it_should_behave_like 'a request'
    it_should_behave_like 'a request with attributes'
  end

  describe '#put' do
    let(:method) { :put }
    let(:error_verb) { 'updating' }
    let(:endpoint) { 'alerts/1' }
    let(:attributes) { { your_mom: 'is such a' } }
    let(:arguments) { [endpoint, attributes] }

    it_should_behave_like 'a request'
    it_should_behave_like 'a request with attributes'
  end

  describe '#delete' do
    let(:method) { :delete }
    let(:error_verb) { 'deleting' }
    let(:endpoint) { 'alerts/1' }
    let(:arguments) { [endpoint] }
    it_should_behave_like 'a request'
    it_should_behave_like 'a request without attributes'
  end
end
