require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
require 'name_drop'
require 'webmock/rspec'

WebMock.disable_net_connect!
