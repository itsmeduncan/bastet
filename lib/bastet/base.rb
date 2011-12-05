require 'singleton'

class Bastet::Base
  include Singleton

  def activate feature, group
    act(:sadd, feature, group)
  end

  def deactivate feature, group
    act(:srem, feature, group)
  end

  def active? feature, entity
    group_names = Bastet.redis.smembers(feature_key(feature))
    groups = Bastet.groups.select { |group| group_names.include?(group.name) }
    groups.any? { |group| group.criteria.call(entity) }
  end

  def inactive? feature, entity
    !active? feature, entity
  end

  private

    def act method, feature, group
      Bastet.redis.send(method, feature_key(feature), group.name)
    end

    def feature_key feature
      "feature_#{feature}"
    end
end
