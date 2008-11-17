require File.dirname(__FILE__) + '/../spec_helper.rb'

describe RAAWS::Operation do
  
  describe "SearchIndex Instance" do
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
  
  def book_search(title="Ada", author="Nabokov")
    @book_search = RAAWS::ItemOperation.search :books_index do |book|
      book.title = title
      book.author = author
    end
  end
  
  
  
end