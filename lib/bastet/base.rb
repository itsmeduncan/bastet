require 'singleton'

class Bastet::Base
  include Singleton

  def activate feature, group
    Bastet.redis.sadd("feature_#{feature}", group.name)
  end

  def deactivate feature, group
    Bastet.redis.srem("feature_#{feature}", group.name)
  end

  def active? feature, entity
    group_names = Bastet.redis.smembers("feature_#{feature}")
    groups = Bastet.groups.select { |group| group_names.include?(group.name) }
    groups.any? { |group| group.criteria.call(entity) }
  end

  def inactive? feature, entity
    !active? feature, entity
  end
end
