require File.dirname(__FILE__) + '/../spec_helper'

describe Parent do
  it "should be valid" do
    Parent.new.should be_valid
  end
end
