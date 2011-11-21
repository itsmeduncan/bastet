require "bastet/version"

module Bastet
  autoload "Base", "bastet/base"

  def self.setup redis
    Bastet::Base.new(redis)
  end
end
