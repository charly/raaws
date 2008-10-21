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
    
    attr_accessor :operation, :search_index, :request, :response, :page
    
    def operation=(type)
      name = self.class.to_s.split("::").last.gsub(/Operation/, ''). + type
      @operation = { :operation => name }
    end
           
    def search_index=(search_index)
      @search_index = "RAAWS::#{search_index.to_s.camelize}".constantize.new
    end
    
    def request=(params)
      @request = returning Request.new do |req|
        req.params = params.merge(operation)
      end
    end
    
    def response=(group)
      @response = returning Response.new do |resp|
        resp.group = group
      end
    end
    
    def result
      raise "No request, no results" unless @request && @response
      @response.hpricot = self.request.send.read
      @result = @response.items
    end

    
  end  
end
