require 'spec_helper'

describe QuikCV::Experience do
  before :each do
    @experience = QuikCV::Experience.new
  end

  it "returns a list of experiences in chronological order" do
    exp1 = Factory :experience, :start_date => 2.weeks.ago
    exp2 = Factory :experience, :start_date => Date.today
    exp3 = Factory :experience, :start_date => 1.year.ago
    QuikCV::Experience.chronological.to_a.should eql [exp2, exp1, exp3]
  end
  
  context "validations" do
    it "has a role" do
      @experience.stub(:role).and_return nil
      @experience.should_not be_valid
      @experience.errors.messages[:role].should include "can't be blank"
    end

    context "with an invalid entry" do
      after :each do
        @experience.should_not be_valid
      end

      it "does not a description" do
        @experience.stub(:description).and_return nil
        @experience.should_not be_valid
        @experience.errors.messages[:description].should include "can't be blank"
      end

      it "has an empty start date" do
        @experience.stub(:start_date).and_return ''
        @experience.should_not be_valid
        @experience.errors.messages[:start_date].should include "can't be blank"
      end

      it "has a valid start date format" do
        @experience.stub(:start_date).and_return 'asfasdfasf'
        @experience.should_not be_valid
        @experience.errors.messages[:start_date].should include "is not a valid date"
      end

      it "has a valid end date format" do
        @experience.stub(:end_date).and_return 'asfasdfasf'
        @experience.should_not be_valid
        @experience.errors.messages[:end_date].should include "is not a valid date"
      end

      it "has a start date that is not set to today or before" do
        @experience.start_date = '23 September 5000'
        @experience.should_not be_valid
        @experience.errors.messages[:start_date].should include "must be on or before #{Date.today}"
      end

      it "has a end date that is not set to today or after" do
        @experience.start_date = Date.today
        @experience.stub(:end_date).and_return '23 September 1900'
        @experience.should_not be_valid
        @experience.errors.messages[:end_date].should include "must be on or after #{Date.today}"
      end

      it "fails with a format of mm-dd-yyyy" do
        @experience.stub(:end_date).and_return '02-23-2009'
        @experience.should_not be_valid
        @experience.errors.messages[:end_date].should include 'is not a valid date'
      end
      
      it "has a start date that is earlier than the end date" do
        @experience.stub(:start_date).and_return Date.today
        @experience.stub(:end_date).and_return Date.today.prev_year
        @experience.should_not be_valid
        @experience.errors.messages[:end_date].should include "must be on or after #{@experience.start_date}"
      end

      it "has a company name" do
        @experience.stub(:company_name).and_return nil
        @experience.should_not be_valid
      end
      
      it "has a company name with 3" do
        @experience.stub!(:company_name).and_return 'a'
        @experience.should_not be_valid
      end
    end

    context "valid entry" do
      it "does not need an end date" do
        @experience = QuikCV::Experience.new(
          company_name: Faker::Lorem.words(2).join(' '),
          role: Faker::Lorem.words(1).join(' '),
          description: Faker::Lorem.sentence(4),
          start_date: Date.yesterday
        )
        # Below causes validation issues between 12am-1am
        # Validations not being displayed by models
        #
        # But stores error in errors_on
        #
        #@experience.start_date = Date.today.to_s
        @experience.should be_valid
        @experience.errors.messages.should be_empty
      end
    end
  end
end