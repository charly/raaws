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
    attr_writer :xml, :hpricot, :result
    
    def operation=(type)
      name = self.class.to_s.split("::").last.gsub(/Operation/, '') + type
      @operation = { :operation => name }
    end
           
    def search_index=(search_index)
      # TODO : Operation.build_search_index(search_index)
      index, opt = case search_index
        when Symbol
          ["RAAWS::#{search_index.to_s.camelize}", '']
        when Hash
          ["RAAWS::#{search_index.keys.first.to_s.camelize}", search_index.values.first]
      end
      @search_index = index.constantize.new(opt)
    end
    
    def request=(params)
      @request = returning Request.new do |req|
        req.params = params.merge(operation)
      end
    end
    
    def response=(group)
      raise "request needs to be initialized/set first" unless @request
      @request.params = { :response_group => group }
      @response = returning Response.new do |resp|
        resp.group = group
      end
    end
    
    def xml
      raise "request needs to be initialized/set first" unless @request
      @xml ||= self.request.send.read
    end
    
    def hpricot
      raise "response needs to be initialized/set first" unless @response
      @hpricot ||= (@response.hpricot=self.xml) && @response.hpricot
    end

    def result
      @result ||= hpricot && self.response.items
    end
    
    # TODO : get number of pages & total result as well
    def page(num)
      @page = reset && @request.params = num.to_s
    end
    
    private
    def reset
      @xml, @hpricot, @result = nil, nil, nil
    end
      

  end
end