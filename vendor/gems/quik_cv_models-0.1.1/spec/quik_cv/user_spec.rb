require 'spec_helper'

describe QuikCV::User do
  before :each do
    @user = QuikCV::User.new
  end
  
  it "can get the users full name" do
    @user.stub(:profile).and_return stub(:first_name => 'Scooby', :last_name => 'Doo')
    @user.full_name.should_not be_nil
  end
  
  describe "validations" do
    it "must have a user name" do
      @user.stub(:username).and_return nil
      @user.should be_invalid
      @user.errors.messages[:username].should eql ["can't be blank"]
    end

    it "must a unique user name" do
      QuikCV::User.create :username => 'foobar', :email => 'y@me.com', :profile => QuikCV::Profile.create(:first_name => 'Scooby', :last_name => 'Doo')
      @user.stub(:username).and_return 'foobar'
      @user.should be_invalid
      @user.errors.messages[:username].should eql ["is already taken"]
    end
    
    it "must have a email address" do
      @user.stub(:email).and_return ''
      @user.should be_invalid
      @user.errors.messages[:email].should eql ["can't be blank"]
    end
    
    it "must have a profile" do
      @user.stub(:profile).and_return nil
      @user.should be_invalid
      @user.errors.messages[:profile].should eql ["can't be blank"]
    end
  end
  
  describe "#has_profile?" do
    it "returns true if there is a profile" do
      @user.stub(:profile).and_return stub
      @user.has_profile?.should be_true
    end

    it "returns false if there is a profile" do
      @user.stub(:profile).and_return nil
      @user.has_profile?.should be_false
    end
  end
end
