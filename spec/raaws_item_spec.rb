require File.dirname(__FILE__) + '/spec_helper.rb'

describe RAAWS::ItemOperation do
  before :all do
    @xml = open(File.dirname(__FILE__) + '/fixtures/item_search_harry_potter.xml').read
  end
  
  describe "Search Index Instance" do
    it "should hold an instance of a **SearchIndex** subclass" do
      arg = book_search.search_index
      arg.class.superclass.should be(RAAWS::SearchIndex)
    end
    
    it "should have title set to Ada" do
      book_search.search_index.title.should == "Ada"
    end
    
    it "should have author set to Proust" do
      arg = book_search(nil, "Proust").search_index
      arg.to_params[:author].should == "Proust"
    end
  end
  
  describe "Request Instance" do
    it "should hold an instance of **Request**" do
      book_search.request.class.should be(RAAWS::Request)
    end
    
    it "should have params hash" do
      book_search.request.params.class.should be(Hash)
    end
    
  end
  
  describe "Response Instance" do
    it "should hold an instance of **Response**" do
      book_search.response.class.should be(RAAWS::Response)
    end
  end
  
  describe "Search Operation" do

    it "should have request.params[:operation] set to 'ItemSearch'" do
      book_search.request.params[:operation].should == "ItemSearch"
      book_search_hash.request.params[:operation].should == "ItemSearch"
    end
    
    it "should have request params[:search_index] set to 'Books'" do
      book_search.request.params[:search_index].should == "Books"
      book_search_hash.request.params[:search_index].should == "Books"
    end
    
    it "should transpose instance variables values in Request#params hash" do
      book_search.request.params[:title].should == "Ada"
      book_search_hash.request.params[:title].should == "Ada"
    end
    
    it "should do the same with Hash instead of Block" do
    
    end
  end
  
  describe "Lookup Operation" do
    it "should have request operation set to 'ItemLookUp'" do
      book_lookup.request.params[:operation].should == "ItemLookup"      
    end
    
    it "should have the Operation set to ItemLookUp" do
      book_lookup.request.uri.query.should match(/Operation=ItemLookup/)
    end
    
    it "should have a ResponseGroup set to Medium by default" do
      book_lookup.request.uri.query.should match(/ResponseGroup=Medium/)
    end
  end
  

  private
  def book_lookup(author="Nabokov")
    @book_lookup ||= RAAWS::ItemOperation.lookup "12A34565567878978", :books_index do |book|
      book.author = author
    end
  end
  
  def book_search(title="Ada", author="Nabokov")
    @book_search = RAAWS::ItemOperation.search :books_index do |book|
      book.title = title
      book.author = author
    end
  end
  
  def book_search_hash(title="Ada", author="Nabokov")
    @book_search = RAAWS::ItemOperation.search(:books_index=>{:title=>title, :author=>author})
  end
  
  
        
end

