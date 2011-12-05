require 'spec_helper'

describe Bastet::Base do
  before do
    @bastet = Bastet::Base.new(@redis)
  end

  describe "initialization" do
    it "should configure the Redis instance" do
      Bastet::Base.new(@redis).redis.should == @redis
    end
  end

  describe "activate" do
    it "should activate the :banana for the group" do
      group = Bastet::Group.new("admins") { |entity| entity.admin? }
      user = mock('user', admin?: true)

      @bastet.activate(:banana, group)
      @bastet.active?(:banana, user).should be_true
    end
  end

  describe "deactivate" do
    it "should deactive :banana for the group" do
      group = Bastet::Group.new("admins") { |entity| entity.admin? }
      user = mock('user', admin?: true)

      @bastet.activate(:banana, group)
      @bastet.active?(:banana, user).should be_true

      @bastet.deactivate(:banana, group)
      @bastet.inactive?(:banana, user).should be_true
    end
  end
end
