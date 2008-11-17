module RAAWS
  ONE_NECESSARY_SEARCH_PARAM =%w<
    Actor Artist AudienceRating Author 
    Brand BrowseNode Composer Conductor CityDirector 
    Keywords Manufacturer MusicLabel Neighborhood
    Orchestra Power Publisher TextStream Title>
    
  class ItemOperation < Operation   
    def self.lookup(item_id, index=nil, &block)
      returning new do |obj|
        obj.operation = "Lookup"
        obj.search_index = index if index
        if block_given?
          yield(obj.search_index)
          obj.request = obj.search_index.to_params
        end
        obj.request = {:item_id => item_id}
        obj.response = "Large"
      end    
    end
    
    def self.search(index, opt={}, &block)
      returning new do |obj|
        obj.operation = "Search"
        obj.search_index = index 
        if block_given?
          yield(obj.search_index)
        end
        obj.request = obj.search_index.to_params
        obj.response = "Small"
      end
    end
    
  end  
end
