module RAAWS
  class BooksIndex < SearchIndex
    AUTHORIZED_PARAMS = %w<
      Author BrowseNode Condition ItemPage Keywords 
      MaximumPrice MerchantId MinimumPrice Power Publisher 
      Sort State TextStream Title>
    

    
  end
end