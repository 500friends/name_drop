require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
require 'name_drop'
require 'webmock/rspec'

# Need to allow codeclimate so we can push our coverage info after a build on Travis
WebMock.disable_net_connect!(allow: 'codeclimate.com')
