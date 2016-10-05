require 'spec_helper'

describe NameDrop::Client do
  describe '#initialize' do
    it 'allows a new client to be instantiated' do
      expect {
        NameDrop::Client.new
      }.to_not raise_error
    end
  end

  let(:client) { NameDrop::Client.new }
  let(:json) { { order: 'Royale with cheese' }.to_json }
  let(:headers) { { 'Content-Type' => 'application/json',
                    'Accept-Version' => '1.8',
                    'Authorization' => 'Bearer NotARealAccessToken' } }
  let(:base_url) { Pathname.new('https://web.mention.net/api/accounts/NotARealAccountID/') }

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
    let(:url) { base_url.join(endpoint).to_s }

    it 'sends the correct request to the configured endpoint' do
      stub_request(method, url).with(headers: headers).to_return(status: 200, body: 'null', headers: {})
      client.public_send(method, *arguments)
      assert_requested(method, url, headers: headers)
    end

    context 'when an exception is returned' do
      it 'raises a NameDrop::Error with a helpful message' do
        stub_request(method, url).with(headers: headers).to_return(status: 404, body: { success: false, code: 404 }.to_json, headers: {})
        expect {
          client.send(method, *arguments)
        }.to raise_error(NameDrop::Error, "Error #{error_verb} Mention Resource")
      end
    end
  end

  shared_examples_for 'a request with attributes' do
    let(:url) { base_url.join(endpoint).to_s }

    it 'sends a payload with the request' do
      stub_request(method, url).with(body: attributes.to_json, headers: headers).to_return(status: 200, body: 'null', headers: {})
      client.send(method, endpoint, attributes)
      assert_requested(method, url, body: attributes.to_json, headers: headers)
    end
  end

  describe '#get' do
    let(:method) { :get }
    let(:error_verb) { 'retrieving' }
    let(:endpoint) { 'alerts' }
    let(:arguments) { [endpoint] }
    it_should_behave_like 'a request'
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
  end
end
