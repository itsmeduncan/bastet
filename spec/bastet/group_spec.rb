require 'spec_helper'

describe Bastet::Group do
  describe "initializer" do
    it "should take a group name" do
      Bastet::Group.new(:cool_feature).name.should == :cool_feature
    end

    it "should always return a symbol" do
      Bastet::Group.new('cooler_feature').name.should == :cooler_feature
    end
  end

  describe "#add" do
    it "should add the User to the group" do
      Bastet::Group.find(:awesome_feature).add(mock('user', id: 20))
      Bastet::Group.find(:awesome_feature).contain?(mock('user', id: 20)).should be_true
    end

    it "should add the symbol to the group" do
      Bastet::Group.find(:awesome_feature).add(:foo)
      Bastet::Group.find(:awesome_feature).contain?(:foo).should be_true
    end

    it "should be aliased as <<" do
      Bastet::Group.find(:awesome_feature) << :foo
      Bastet::Group.find(:awesome_feature).contain?(:foo).should be_true
    end
  end

  describe "#remove" do
    it "should remove the User from the group" do
      Bastet::Group.find(:awesome_feature).add(mock('user', id: 20))

      lambda {
        Bastet::Group.find(:awesome_feature).remove(mock('user', id: 20))
      }.should change(Bastet::Group.find(:awesome_feature), :count).by(-1)
    end

    it "should remove the symbol from the group" do
      Bastet::Group.find(:awesome_feature).add(:foo)

      lambda {
        Bastet::Group.find(:awesome_feature).remove(:foo)
      }.should change(Bastet::Group.find(:awesome_feature), :count).by(-1)
    end
  end

  describe "#count" do
    it "should return the count of the set" do
      group = Bastet::Group.find(:awesome_feature)
      group.add(:foo)
      group.count.should eql(1)
    end
  end
end
