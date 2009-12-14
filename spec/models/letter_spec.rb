require File.dirname(__FILE__) + '/../spec_helper'

describe Letter do
  it "should be valid" do
    Letter.new.should be_valid
  end
end
