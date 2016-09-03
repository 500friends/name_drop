require 'spec_helper'

describe NameDrop::Configuration do
  context 'nothing is specified for account_id' do
    it 'uses default dummy account_id' do
      expect(NameDrop.configuration.account_id).to eq('NotARealAccountID')
    end
  end

  context 'account_id is specified' do
    it 'uses specified account_id' do
      NameDrop.configure { |config| config.account_id = 'qwerty' }
      expect(NameDrop.configuration.account_id).to eq('qwerty')
    end
  end

  context 'nothing is specified for access_token' do
    it 'uses default dummy access_token' do
      expect(NameDrop.configuration.access_token).to eq('NotARealAccessToken')
    end
  end

  context 'access_token is specified' do
    it 'uses specified access_token' do
      NameDrop.configure { |config| config.access_token = 'dvorak' }
      expect(NameDrop.configuration.access_token).to eq('dvorak')
    end
  end

  context 'configuration is passed a Configuration object' do
    it 'stores module configuration' do
      my_config = NameDrop::Configuration.new
      my_config.account_id = 'asdf'
      my_config.access_token = 'fdsa'
      NameDrop.configuration = my_config
      expect(NameDrop.configuration.account_id).to eq('asdf')
      expect(NameDrop.configuration.access_token).to eq('fdsa')
    end
  end
end
