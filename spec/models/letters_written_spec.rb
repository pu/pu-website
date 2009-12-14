require 'spec_helper'

describe LettersWritten do
  before(:each) do
    @valid_attributes = {
      :kid_id => 1,
      :letter_id => 1,
      :received => false
    }
  end

  it "should create a new instance given valid attributes" do
    LettersWritten.create!(@valid_attributes)
  end
end
