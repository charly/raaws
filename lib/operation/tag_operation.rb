module RAAWS
  ONE_NECESSARY_SEARCH_PARAM =%w<
    Actor Artist AudienceRating Author 
    Brand BrowseNode Composer Conductor CityDirector 
    Keywords Manufacturer MusicLabel Neighborhood
    Orchestra Power Publisher TextStream Title>
    
  class TagOperation < Operation
    def self.look_up(name, &block)
      new.look_up(asin, &block)
    end
    
    def look_up(name, &block)
    end
    
  end  
end