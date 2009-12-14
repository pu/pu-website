require File.dirname(__FILE__) + '/../spec_helper'

describe Kid do
  it "should be valid" do
    Kid.new.should be_valid
  end
end
