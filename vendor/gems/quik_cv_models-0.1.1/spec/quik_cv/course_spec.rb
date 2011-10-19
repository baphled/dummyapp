require 'spec_helper'

describe QuikCV::Course do
  before(:each) do
    @course = QuikCV::Course.new
  end

  it "returns a list of courses in chronological order" do
    course1 = Factory :course, :start_date => 2.weeks.ago
    course2 = Factory :course, :start_date => Date.today
    course3 = Factory :course, :start_date => 1.year.ago
    QuikCV::Course.chronological.to_a.should eql [course2, course1, course3]
  end
  
  it "must have a title" do
    @course.title = ''
    @course.should be_invalid
  end
  
  it "must have a start date" do
    @course.start_date = ''
    @course.should be_invalid
  end
  
  describe "of dates" do
    
    it "start dates must be a date" do
      lambda {@course.start_date = 'foo'}.should raise_error
    end
    
    it "end dates must be a date" do
      lambda {@course.end_date = 'foo'}.should raise_error
    end
    
    it "end date must be after the start date" do
      @course.start_date = Time.now
      @course.end_date = Time.now.prev_year
      @course.should be_invalid
      @course.errors.messages[:end_date].should_not be_empty
    end
  end
end
