require File.dirname(__FILE__) + '/spec_helper.rb'

describe RAAWS::ItemOperation do
  before :all do
    @xml = open(File.dirname(__FILE__) + '/fixtures/item_search_harry_potter.xml').read
  end
  
  it "should hold an instance of a **SearchIndex** subclass" do
    arg = book_search.search_index
    arg.class.superclass.should be(RAAWS::SearchIndex)
  end
    
  it "should hold an instance of **Request**" do
    book_search.request.class.should be(RAAWS::Request)
  end
  
  it "should hold an instance of **Response**" do
    book_search.response.class.should be(RAAWS::Response)
  end  
  
  describe "Search Index Instance" do 
    it "should have title set to Ada" do
      book_search.search_index.title.should == "Ada"
    end
    
    it "should have author set to Proust" do
      arg = book_search(nil, "Proust").search_index
      arg.to_params[:author].should == "Proust"
    end
  end
  
  describe "Request Instance" do     
    it "should have params hash" do
      book_search.request.params.class.should be(Hash)
    end
    
  end
  
  describe "Search Operation" do
    it "should have request.params[:operation] set to 'ItemSearch'" do
      book_search.request.params[:operation].should == "ItemSearch"
    end
    
    it "should have request params[:search_index] set to 'Books'" do
      book_search.request.params[:search_index].should == "Books"
    end
    
    it "should transpose instance variables values in Request#params hash" do
      book_search.request.params[:title].should == "Ada"
    end
  end
  
  describe "Look Up Operation" do
    it "should have request operation set to 'ItemLookUp'" do
      book_look_up.request.params[:operation].should == "ItemLookUp"      
    end
  end
  

  private
  def book_look_up(author="Nabokov")
    @book_look_up ||= RAAWS::ItemOperation.look_up "12A34565567878978", :books_index do |book|
      book.author = author
    end
  end
  
  def book_search(title="Ada", author="Nabokov")
    @book_search = RAAWS::ItemOperation.search :books_index do |book|
      book.title = title
      book.author = author
    end
  end        
end

