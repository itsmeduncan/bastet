class Bastet::Group
  attr_accessor :name, :criteria

  def initialize name, &block
    raise ArgumentError.new("Need to pass a criteria") unless block_given?
    validate_name!(name.to_s)

    @name = name.to_s
    @criteria = block

    persist!
  end

  def self.find name
    Bastet.groups.detect { |group| group.name == name }
  end

  def contains? entity
    criteria.call(entity) rescue false
  end

  private

    def validate_name! name
      if Bastet.redis.sismember('bastet_groups', name)
        raise ArgumentError.new("#{name} is already initialized as a group.")
      else
        Bastet.redis.sadd('bastet_groups', name)
      end
    end

    def persist!
      Bastet.groups << self
    end
end
