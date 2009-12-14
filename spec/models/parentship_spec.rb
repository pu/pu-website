require File.dirname(__FILE__) + '/../spec_helper'

describe Parentship do
  it "should be valid" do
    Parentship.new.should be_valid
  end
end
