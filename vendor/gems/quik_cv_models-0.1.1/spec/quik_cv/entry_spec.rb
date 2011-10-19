require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'quik_cv', 'entry')

describe QuikCV::Entry do
  before :each do
    @entry = QuikCV::Entry.new
  end
  
  it "must have a title" do
    @entry.should be_invalid
    @entry.errors.messages[:title].should eql ["can't be blank"]
  end
  
  it "must have some content" do
    @entry.should be_invalid
    @entry.errors.messages[:content].should eql ["can't be blank"]
  end
end