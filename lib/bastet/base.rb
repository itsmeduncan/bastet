class Bastet::Base
  attr_accessor :redis

  def initialize redis
    @redis = Bastet.redis = redis
  end

  def activate feature, group
    @redis.sadd("feature_#{feature}", group.name)
  end

  def deactivate feature, group
    @redis.srem("feature_#{feature}", group.name)
  end

  def active? feature, entity
    group_names = @redis.smembers("feature_#{feature}")
    groups = Bastet.groups.select { |group| group_names.include?(group.name) }
    groups.any? { |group| group.criteria.call(entity) }
  end

  def inactive? feature, entity
    !active? feature, entity
  end
end
