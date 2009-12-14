require File.dirname(__FILE__) + '/../spec_helper'

describe School do
  it "should be valid" do
    School.new.should be_valid
  end
end
