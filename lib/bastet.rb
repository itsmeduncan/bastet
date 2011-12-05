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

    def groups
      @@groups ||= []
    end

    def setup(redis)
      self.redis = redis
      Bastet::Base.instance
    end
  end
end
