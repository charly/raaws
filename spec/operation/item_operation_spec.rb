require File.dirname(__FILE__) + '/../spec_helper.rb'

describe RAAWS::ItemOperation do
  before :all do
    @xml = open(File.dirname(__FILE__) + '/../fixtures/item_search_harry_potter.xml').read
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

