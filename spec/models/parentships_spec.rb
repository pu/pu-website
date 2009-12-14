require File.dirname(__FILE__) + '/../spec_helper'

describe Parentships do
  it "should be valid" do
    Parentships.new.should be_valid
  end
end
