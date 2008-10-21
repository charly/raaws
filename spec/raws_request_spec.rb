require File.dirname(__FILE__) + '/spec_helper.rb'

describe RAAWS::Request do
  
  it "should set base_url on creation" do
    pending
  end
   
  describe "PARAMS (see: Hash#update)" do
    it "should camelize hash keys" do
      b = RAAWS::Request.new.camelize_hash_keys( {:access_key => "chaplin"} )
      b["AccessKey"].should == "chaplin"
    end
    
    it "should correctly update params with new values" do
      req = RAAWS::Request.new
      req.params = {:author => "Buster Keaton"}
      req.params[:author].should == "Buster Keaton"
    end
    
    it "should correctly add new values to params" do
      req = RAAWS::Request.new
      req.params = {:title => "Modern Times"}
      req.params[:title].should == "Modern Times"
    end
  end
  
  describe "URI" do
    it "should be an URI::HTTP" do
      RAAWS::Request.new.uri.class.should be(URI::HTTP)
    end
    
    it "should have an AWRAAWSccessKey => 1GGP2X6SNBRNARDHET82" do
      RAAWS::Request.new.uri.query.should match(/AWSAccessKeyId=1GGP2X6SNBRNARDHET82/)
    end
    
   it "should test something here" do
     pending
     req = RAAWS::Request.new; req.params ={"SearchIndex"=>"DVD", "Director"=>"Charlie Chaplin"}
     el = Hpricot::XML(req.send)
     el_attr = (el/"Item").last.at("ItemAttributes").at("Title").innerHTML
     el_attr.should == "hjklkjhj"
   end
    
  end
  

end