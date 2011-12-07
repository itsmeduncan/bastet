require 'spec_helper'

describe Bastet::Base do
  before do
    @bastet = Bastet.setup(@redis)
  end

  describe "activate" do
    it "should activate the :banana for the group" do
      group = Bastet::Group.new("admins") { |entity| entity.admin? }
      user = mock('user', admin?: true)

      @bastet.activate(:banana, group)
      @bastet.active?(:banana, user).should be_true
    end

    describe "complex criteria" do
      before do
        @group = Bastet::Group.new("20_percent") { |entity| (entity.id % 10) < (20 / 10) }
        @bastet.activate(:secret_feature, @group)
      end

      it "should be true for the user" do
        user = mock('user', id: 20)
        @bastet.active?(:secret_feature, user).should be_true
      end

      it "should be false for the user" do
        user = mock('user', id: 19)
        @bastet.active?(:secret_feature, user).should be_false
      end
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

  describe "default to inactive" do
    it "should default to inactive for new features" do
      user = mock('user')
      @bastet.active?(:unknown_feature, user).should be_false
    end
  end
end
