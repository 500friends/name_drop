require 'spec_helper'

describe NameDrop::Resources::Mention do
  let(:client) { NameDrop::Client.new }
  let(:mention) { NameDrop::Resources::Mention.new(client) }

  describe '#all' do
    context 'when since_id is not passed' do
      it 'calls get on client, with empty attributes' do
        expect(client).to receive(:get).with('alerts/1/mentions', {}).and_return('mentions' => [{ 'a' => 'b' }, { 'c' => 'd' }])
        NameDrop::Resources::Mention.all(client, alert_id: 1)
      end
    end

    context 'when since_id is passed' do
      it 'calls get on client, with since_id in attributes hash' do
        expect(client).to receive(:get).with('alerts/1/mentions', { since_id: 12345 }).and_return('mentions' => [{ 'a' => 'b' }, { 'c' => 'd' }])
        NameDrop::Resources::Mention.all(client, alert_id: 1, since_id: 12345)
      end
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

  describe '#children' do
    let(:children_attributes) {
      {
        'children' => [
          {
            'id' => '9',
            'alert_id' => '1',
            'title' => 'i am a child'

          },
          {
            'id' => '10',
            'alert_id' => '1',
            'title' => 'another child'

          },
        ]
      }
    }

    before do
      mention.attributes[:id] = '2'
      mention.attributes[:alert_id] = '1'
    end

    it 'calls get on client with the correct endpoint and params' do
      expect(client).to receive(:get).with('alerts/1/mentions/2/children', { limit: 2 }).and_return(children_attributes)
      mention.children(limit: 2)
    end

    context 'when there are children' do
      before do
        allow(client).to receive(:get).and_return(children_attributes)
      end

      it 'initializes Mention resource objects for each child' do
        expect(mention.children.map(&:class).uniq).to eq [NameDrop::Resources::Mention]
        expect(mention.children.map { |c| c.attributes['title'] }).to match_array ['i am a child', 'another child']
      end
    end
  end

  describe '.endpoint' do
    it 'returns alerts/:alert_id/mentions' do
      expect(NameDrop::Resources::Mention.endpoint(alert_id: 1)).to eq('alerts/1/mentions')
    end
  end
end
