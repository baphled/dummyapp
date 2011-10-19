require 'spec_helper'

describe QuikCV::Qualification do
  before(:each) do
    @qualification = QuikCV::Qualification.new
  end
  
  it "must have a place" do
    @qualification.place = nil
    @qualification.should be_invalid
    @qualification.errors.messages[:place].should eql ["can't be blank"]
  end
  
  it "must have a course" do
    @qualification.course = nil
    @qualification.should be_invalid
    @qualification.errors.messages[:place].should eql ["can't be blank"]
  end
  
  it "must have a start date" do
    @qualification.start_date = nil
    @qualification.should be_invalid
    @qualification.errors.messages[:place].should eql ["can't be blank"]
  end
  
  it "returns a list of qualifications in chronological order" do
    qualification1 = Factory :qualification, :start_date => 2.weeks.ago
    qualification2 = Factory :qualification, :start_date => Date.today
    qualification3 = Factory :qualification, :start_date => 1.year.ago
    QuikCV::Qualification.chronological.to_a.should eql [qualification2, qualification1, qualification3]
  end
  
  describe "date validations" do
    it "has a valid start date format" do
      @qualification.stub(:start_date).and_return 'asfasdfasf'
      @qualification.should_not be_valid
      @qualification.errors.messages[:start_date].should include "is not a valid date"
    end

    it "has a valid end date format" do
      @qualification.stub(:end_date).and_return 'asfasdfasf'
      @qualification.should_not be_valid
      @qualification.errors.messages[:end_date].should include "is not a valid date"
    end

    it "has a start date that is not set to today or before" do
      @qualification.start_date = '23 September 5000'
      @qualification.should_not be_valid
      @qualification.errors.messages[:start_date].should include "must be on or before #{Date.today}"
    end

    it "has a end date that is not set to today or after" do
      @qualification.start_date = Date.today
      @qualification.stub(:end_date).and_return '23 September 1900'
      @qualification.should_not be_valid
      @qualification.errors.messages[:end_date].should include "must be on or after #{Date.today}"
    end

    it "fails with a format of mm-dd-yyyy" do
      @qualification.stub(:end_date).and_return '02-23-2009'
      @qualification.should_not be_valid
      @qualification.errors.messages[:end_date].should include 'is not a valid date'
    end
  end
end
