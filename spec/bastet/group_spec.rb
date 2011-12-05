require 'spec_helper'

describe Bastet::Group do
  before do
    @bastet = Bastet.setup(@redis)
  end

  describe "initializer" do
    it "should take a group name" do
      Bastet::Group.new('cool_feature') { }.name.should == "cool_feature"
    end

    it "should always return a string" do
      Bastet::Group.new('cooler_feature') { }.name.should be_a(String)
    end

    it "should take a required criteria block" do
      Bastet::Group.new('bananas') { }.criteria.should be_a(Proc)
    end

    it "should raise an argument error if there is no block" do
      lambda {
        Bastet::Group.new('cooler_feature')
      }.should raise_exception(ArgumentError)
    end

    it "should make sure the name is unique" do
      Bastet::Group.new('cooler_feature') { }
      ['cooler_feature', :cooler_feature].each do |name|
        lambda {
          Bastet::Group.new(name) { }
        }.should raise_exception(ArgumentError)
      end
    end

    it "should add the group to the groups" do
      lambda {
        Bastet::Group.new('banana') { }
      }.should change(Bastet.groups, :count).by(1)
    end
  end

  describe "contains?" do
    it "should be true if the criteria matches" do
      group = Bastet::Group.new('admins_only') { |entity| entity.admin? }
      group.contains?(mock(admin?: true)).should be_true
    end

    it "should be false if the criteria doesn't match" do
      group = Bastet::Group.new('people_named_bill') { |entity| entity.name == "Bill" }
      group.contains?(mock(name: 'Joe')).should be_false
    end

    it "should be true for all" do
      group = Bastet::Group.new('all') { |entity| true }
      group.contains?(mock).should be_true
    end

    it "should be false for all" do
      group = Bastet::Group.new('none') { |entity| false }
      group.contains?(mock).should be_false
    end
  end
end
