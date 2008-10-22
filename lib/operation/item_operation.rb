module RAAWS
  ONE_NECESSARY_SEARCH_PARAM =%w<
    Actor Artist AudienceRating Author 
    Brand BrowseNode Composer Conductor CityDirector 
    Keywords Manufacturer MusicLabel Neighborhood
    Orchestra Power Publisher TextStream Title>
    
  class ItemOperation < Operation   
    def self.look_up(asin, index=nil, &block)
      returning new do |obj|
        obj.operation = "LookUp"
        obj.search_index = index if index
        if block_given?
          yield(obj.search_index)
          obj.request = obj.search_index.to_params
        end
        obj.request = {:asin => asin}
      end    
    end
    
    def self.search(index, &block)
      returning new do |obj|
        obj.operation = "Search"
        obj.search_index = index 
        yield(obj.search_index) if block_given?
        obj.request = obj.search_index.to_params
        obj.response = "Small"
      end
    end
    
  end  
end
