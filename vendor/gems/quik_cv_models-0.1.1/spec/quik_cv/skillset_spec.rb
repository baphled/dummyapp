require 'spec_helper'


describe QuikCV::Skillset do
  before :each do
    @skillset = QuikCV::Skillset.new
  end
  
  describe "validations" do
    it "must have a skill type" do
      @skillset.should be_invalid
      @skillset.errors.messages[:type].should include "can't be blank"
    end
    
    it "has a type with less than 3 characters" do
      @skillset.type = 'fo'
      @skillset.should be_invalid
      @skillset.errors.messages[:type].should eql ["is too short (minimum is 3 characters)"]
    end
    
    it "has a skills list" do
      @skillset.should be_invalid
      @skillset.errors.messages[:skills].should include "can't be blank"
    end
  end
end