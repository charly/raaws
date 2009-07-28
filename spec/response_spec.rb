require File.dirname(__FILE__) + '/spec_helper.rb'

describe RAAWS::Response do
  before :all do
    @response = RAAWS::Response.new  
    @xml = open( File.dirname(__FILE__) + '/fixtures/item_search_harry_potter.xml' ).read
  end
  
  it "should use Hpricot to parse xml response from amazon" do
    @response.hpricot = @xml
    @response.items.first.should == ""
  end
  
  
  
end