module RAAWS
  OPERATION = %w<
    CartAdd CartClear CartCreate CartGet CartModify
    CustomerContentLookUp CustomerContentSearch Help
    ItemLookUp ItemSearch ListLookUp ListSearch
    SellerListingLookUp SellerListingSearch SellerLookUp
    TagLookUp TransactionLookUp 
    VehiclePartLookUp VehiclePartSearch VehicleSearch>

  
  class Operation
    attr_accessor :operation, :search_index, :request, :response, :page
    
    def operation=(type)
      name = self.class.to_s.split("::").last.gsub(/Operation/, '') + type
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
    
    def xml
      raise "request needs to be initialized/set first" unless @request
      @xml = self.request.send.read
    end
    
    def result
      raise "response needs to be initialized/set first" unless @response
      @response.hpricot = self.xml
      @result = @response.items
    end

  end
end