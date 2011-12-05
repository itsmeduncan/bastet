require 'simplecov'
SimpleCov.start

require 'bundler'
require 'redis'
require 'bastet'

Bundler.setup

RSpec.configure do |config|
  config.mock_with :mocha

  config.before(:each) do
    @redis = Redis.new
  end

  config.after(:each) do
    @redis.flushdb
    Bastet.groups = []
  end
end
