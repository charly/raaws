require File.dirname(__FILE__) + '/spec_helper.rb'

describe RAAWS::Request do
   
  describe "PARAMS workflow" do
    before(:each) { @request =  RAAWS::Request.new }
    
    it "adds new values to params" do
      @request.params = {:title => "Modern Times"}
      @request.params[:title].should == "Modern Times"
    end
    
    it "updates params" do
      @request.params = {:author => "Charlie Chaplin"}
      @request.params = {:author => "Buster Keaton"}
      @request.params[:author].should == "Buster Keaton"
    end
    
    it "adds a timestamp to params" do
      @request.add_timestamp_to_params({:title => "Kid"})[:timestamp].
      should match(Regexp.new(Time.now.year.to_s))
    end
    
    it "camelizes params keys" do
      @request.camelize_params({:access_key => "chaplin", :title => "Kid"}).
      should == {"AccessKey" => "chaplin", "Title" => "Kid"}
    end
    
    it "encodes params values" do
      @request.encode_params({
        :timestamp => "2009-09-22T12:05:39+02:00",
        :title => "Modern Times"
        }).should == {
          :title=>"Modern%20Times", 
          :timestamp=>"2009-09-22T12%3A05%3A39%2B02%3A00"
        }
    end
       
    it "sorts params byte wise (not alphabetically) for signature" do
      #%w(AWS Z Author ).sort_by { |s| s.downcase  }.should == %w(Author AWS Z)
      @request.sort_params({"ZZ" => "bla", "AWS" => "123", "Author" => "chap" }).
      should == [["Author", "chap"], ["AWS", "123"], ["ZZ", "bla"]]
    end
  end
    
  describe "URLString workflow" do
    before(:each) do
      @request = RAAWS::Request.new
      @params = [["author", "chaplin"], ["title", "kid"]]
    end
    
    it "creates an url string from params" do
       @request.params_to_string(@params).should == "author=chaplin&title=kid"
    end
    
    it "creates the signature string from params" do
      @request.string_for_signature("author=chaplin&title=kid").
        should == "GET\nwebservices.amazon.com\n/onca/xml\nauthor=chaplin&title=kid"
    end
    
    it "creates the signature" do
      str_sign = @request.string_for_signature("author=chaplin&title=kid")
      @request.signature(str_sign).should == "luIKHpS4nH7oJH7qthiFqFn+b1bgqSZ2biRNEXC5sd8="
    end
    
    it "encodes properly the signature" do
      @request.url_encode("luIKHpS4nH7oJH7qthiFqFn+b1bgqSZ2biRNEXC5sd8=").
        should == "luIKHpS4nH7oJH7qthiFqFn%2Bb1bgqSZ2biRNEXC5sd8%3D"
    end  
  end
  
  describe "URI" do
    before(:each) do
      @request = RAAWS::Request.new({:title => "Modern Times"})
    end
    
    it "has a preset of params on initialisation" do
      pending
      @request.params.should == {}
    end
    
    it "processes params" do
      pending
      @request.process_params.should be_a(Hash)
      @request.process_params.should == ""
    end #just to check it works give it should == "" to see
    
    it "processes url string" do
      pending
      @request.process_url_string.should == ""
    end
    
    it "has the final url address" do
      @request.params= { :operation => "ItemSearch", :search_index => "DVD", :response_group => "Small"}
      @request.uri.should == ""
    end
    
    it "gets an xml file from amazon" do
      @request.params= {:search_index => "DVD", :operation => "ItemSearch", :response_group => "Small"}
      @request.get.read.should == ""
    end
  end
  

end