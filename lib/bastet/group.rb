class Bastet::Group
  attr_accessor :name

  def initialize name
    @name = name.to_sym
  end

  def self.find name
    new(name)
  end

  def add entity
    Bastet.redis.sadd(name, entity_identifier(entity))
  end
  alias_method :<<, :add

  def remove entity
    Bastet.redis.srem(name, entity_identifier(entity))
  end

  def contain? entity
    Bastet.redis.sismember(name, entity_identifier(entity))
  end
  alias_method :exist?, :contain?

  def count
    Bastet.redis.scard name
  end

  private

    def entity_identifier(entity)
      entity.respond_to?(:id) ? "#{class_name(entity)}_#{entity.id}" : entity.to_s
    end

    def class_name(entity)
      name.class.name.downcase
    end
end
