module RAAWS
  class BookIndex < SearchIndex
    AUTHORIZED_PARAMS = %w<
      Author BrowseNode Condition ItemPage Keywords 
      MaximumPrice MerchantId MinimumPrice Power Publisher 
      Sort State TextStream Title>
    
    attr_accessor :author, :publisher, :title, :search_index
    def initialize
      @search_index = "Books"
    end
    
  end
end