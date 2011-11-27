class Bastet::Base
  attr_accessor :redis

  def initialize redis
    @redis = Bastet.redis = redis
  end

  def activate feature, target
    act :sadd, feature, target
  end

  def deactivate feature, target
    act :srem, feature, target
  end

  def active? feature, target
    act :sismember, feature, target
  end

  def inactive? feature, target
    !active? feature, target
  end

  private

    def act method, feature, target
      @redis.send(method, key(feature, target), val(target))
    end

    def key feature, target
      [].tap do |key|
        key << "feature"
        key << feature.to_s
        key << namespace(target)
      end.join(":")
    end

    def val target
      instance?(target) ? target.id : target.to_s
    end

    def namespace target
      instance?(target) ? "users" : "groups"
    end

    def instance? target
      target.respond_to?(:id)
    end
end
