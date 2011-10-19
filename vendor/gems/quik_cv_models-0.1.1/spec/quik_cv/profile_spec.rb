require 'spec_helper'

describe QuikCV::Profile do
  before :all do
    @profile = QuikCV::Profile.new
  end

  context "validations" do
    before(:each) do
      @profile.should be_invalid
    end
    
    it "must have a first name" do
      @profile.errors.messages[:first_name].should eql ["can't be blank" ]
    end

    it "must have a last name" do
      @profile.errors.messages[:last_name].should eql ["can't be blank" ]
    end
  end

  describe "#has_entries?" do
    before(:each) do
      @skillsets = []
      3.times { @skillsets << stub.as_null_object }
      @profile.stub!(:skillsets).and_return(@skillsets)
      @profile.stub!(:qualifications).and_return [stub.as_null_object]
      @profile.stub!(:entries).and_return [stub.as_null_object]
      @profile.stub(:experiences).and_return []
    end
      
    context "returns false" do
      it "does not have a custom entry" do
        @profile.stub!(:entries).and_return []
        @profile.should_not have_entries
      end
      
      it "does not have a employment entry" do
        @profile.stub(:experiences).and_return []
        @profile.stub(:qualifications).and_return []
        @profile.should_not have_entries
      end

      it "does not have a education entry" do
        @profile.stub(:qualifications).and_return []
        @profile.should_not have_entries
      end

      it "does not have 3 skillset entries" do
        @profile.stub(:skillsets).and_return []
        @profile.should_not have_entries
      end
    end

    context "returns true" do
      it "returns true there is 1 custom entry, 1 qualification and 3 skill sets" do
        @profile.has_entries?.should eql true
      end

      it "returns true there is 1 custom entry, 1 job and 3 skill sets " do
        @profile.stub(:qualifications).and_return []
        @profile.stub!(:experiences).and_return [stub]
        @profile.has_entries?.should eql true
      end
      
    end
  end
end
