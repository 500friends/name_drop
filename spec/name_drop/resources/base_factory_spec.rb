require 'spec_helper'

require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext/object'

describe NameDrop::Resources::BaseFactory do
  let(:client) { NameDrop::Client.new }
  let(:attr) { { 'asdf' => 'jkl;' } }

  shared_examples_for 'resource' do
    describe '.delegate_to_target' do
      it 'sets client instance variable' do
        resource_factory = NameDrop::Resources::BaseFactory.new(client, resource_name)
        resource = resource_factory.build(attr)
        expect(resource.class).to eq("NameDrop::Resources::#{resource_name}".constantize)
      end
    end
  end

  context 'alert' do
    let(:resource_name) { 'Alert' }

    it_behaves_like 'resource'
  end

  context 'mention' do
    let(:resource_name) { 'Mention' }

    it_behaves_like 'resource'
  end

  context 'share' do
    let(:resource_name) { 'Share' }

    it_behaves_like 'resource'
  end
end
