require 'spec_helper'

describe Bastet::Base do
  before do
    @redis = Redis.new
    @bastet = Bastet::Base.new(@redis)
  end

  describe "initialization" do
    it "should configure the Redis instance" do
      Bastet::Base.new(@redis).redis.should == @redis
    end
  end

  describe "activate" do
    it "should activate the :banana for the user" do
      user = mock('user')
      user.expects(:id).at_least(2).returns(100)

      @bastet.activate(:banana, user)
      @bastet.active?(:banana, user).should be_true
    end

    it "should activate the :banana for the group" do
      @bastet.activate(:banana, :admins)
      @bastet.active?(:banana, :admins).should be_true
    end
  end

  describe "deactivate" do
    it "should deactivate the :banana for the user" do
      user = mock('user')
      user.expects(:id).at_least(2).returns(100)

      @bastet.activate(:banana, user)
      @bastet.active?(:banana, user).should be_true

      @bastet.deactivate(:banana, user)
      @bastet.inactive?(:banana, user).should be_true
    end

    it "should deactivate the :banana for the group" do
      @bastet.activate(:banana, :admins)
      @bastet.active?(:banana, :admins).should be_true

      @bastet.deactivate(:banana, :admins)
      @bastet.inactive?(:banana, :admins).should be_true
    end
  end
end
