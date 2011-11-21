require 'bundler'
require 'redis'
require 'bastet'

Bundler.setup

RSpec.configure do |config|
  config.mock_with :mocha
end
