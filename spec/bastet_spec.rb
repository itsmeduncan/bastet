require 'spec_helper'

describe Bastet do
  describe "::setup" do
    it "should return a new Bastet::Base object" do
      Bastet.setup(@redis).should be_a(Bastet::Base)
    end
  end

  describe "::groups" do
    it "should have no groups" do
      Bastet.groups.should be_empty
    end
  end
end
