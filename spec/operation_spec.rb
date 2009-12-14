require File.dirname(__FILE__) + '/spec_helper.rb'


describe RAAWS::Operation do
  before(:all) do
    @uri = "http://ecs.amazonaws.com/onca/xml?AWSAccessKeyId=1GGP2X6SNBRNARDHET82&AssociateTag=charliechap0e-20&Author=Nabokov&Operation=ItemSearch&ResponseGroup=Small&SearchIndex=Books&Service=AWSECommerceService&Title=Ada&Version=2008-10-07"
    @xml = open(File.dirname(__FILE__) + '/fixtures/item_search_harry_potter.xml').read
  end
  
  describe "SearchIndex Instance with 'Ada' from 'Nabokov' " do
    it "holds an instance of a **SearchIndex** subclass" do
      arg = book_search.search_index
      arg.class.superclass.should be(RAAWS::SearchIndex)
    end
    
    it "has title set to Ada" do
      book_search.search_index.title.should == "Ada"
    end
    
    it "has author set to Proust" do
      arg = book_search(nil, "Proust").search_index
      arg.to_params[:author].should == "Proust"
    end
  end
  
  describe "Request Instance" do
    it "holds an instance of **Request**" do
      book_search.request.class.should be(RAAWS::Request)
    end
    
    it "gives the url of the request" do
      book_search.url.should == @uri
    end
    
    it "has params hash" do
      book_search.request.params.class.should be(Hash)
    end
    
    it "updates params hash" do
      (b=book_search).request.params={:author => "Proust", :title => "Recherche"}
      b.request.params[:author].should == "Proust"
    end  
  end
  
  describe "Response Instance" do
    before(:all) do
      FakeWeb.register_uri(:get, @uri, :string => @xml )
    end
    
    it "holds an instance of **Response**" do
      book_search.response.class.should be(RAAWS::Response)
    end
    
    it "holds the xml result from amazon" do
      book_search.xml.should == @xml
    end
    
    it "holds with hpricot(deprecate this!) a nokogiri instance" do
      book_search.hpricot.at("Title").inner_text.should == 'Harry Potter'
    end
  end
  
  def book_search(title="Ada", author="Nabokov")
    @book_search = RAAWS::ItemOperation.search :books_index do |book|
      book.title = title
      book.author = author
    end
  end
  
  
  
end