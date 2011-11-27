require 'bastet/version'
require 'bastet/base'
require 'bastet/group'

module Bastet
  class << self
    def redis
      @@redis
    end

    def redis=(redis)
      @@redis = redis
    end

    def setup(redis)
      Bastet::Base.new(redis)
    end
  end
end
