require 'spec_helper'

describe Bastet do
  before do
    @redis = Redis.new
  end

  describe "::setup" do
    it "should return a new Bastet::Base object" do
      Bastet.setup(@redis).should be_a(Bastet::Base)
    end
  end
end
