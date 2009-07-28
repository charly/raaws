module RAAWS
  OPERATION = %w<
    CartAdd CartClear CartCreate CartGet CartModify
    CustomerContentLookUp CustomerContentSearch Help
    ItemLookUp ItemSearch ListLookUp ListSearch
    SellerListingLookUp SellerListingSearch SellerLookUp
    TagLookUp TransactionLookUp 
    VehiclePartLookUp VehiclePartSearch VehicleSearch>

  
  class Operation
    attr_reader :operation, :search_index, :request, :response, :page
    attr_writer :xml, :hpricot, :result
    
    # Given an operation type (e.g: Lookup or Search) 
    # it sets the Operation param on the request.
    def operation=(type)
      name = self.class.to_s.split("::").last.gsub(/Operation/, '') + type
      @operation = { :operation => name }
    end
           
    # Given a Hash or a Symbol of the search index (e.g BookIndex or DVDIndex) 
    # it creates an *instance of RAAWS::(Book)Index* and sets SearchIndex param.
    # TODO : Not sure about the API here !!!!
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
    
    # Given a Hash of Params collected in Operation SearchIndex
    # it creates an *instance of RAAWS::Request* which constructs the url.
    def request=(params)
      @request = returning Request.new do |req|
        req.params = params.merge(operation)
      end
    end
    
    # Given a group response (e.g : Large or Small)
    # it creates an *instance of Response* (very basic)
    # and  will parse some xml response
    def response=(group)
      raise "request needs to be initialized/set first" unless @request
      @request.params = { :response_group => group }
      @response = returning Response.new do |resp|
        resp.group = group
      end
    end
    
    # When this method is called the network connection is made :
    # it calls hpricot which calls xml which calls Request#get.
    # TODO : Refactor !
    def result
      @result ||= hpricot && self.response.items
    end
    
    #
    def hpricot
      raise "response needs to be initialized/set first" unless @response
      @hpricot ||= (@response.hpricot=self.xml) && @response.hpricot
    end
    
    #
    def xml #=(xml)
      raise "request needs to be initialized/set first" unless @request
      @xml ||= self.request.get
    end


    # TODO : current_page
    def page(num)
      #see sub class
    end
    
    # A proxy for Request#uri, will return the url 
    def url
      @request.uri.to_s
    end

    
    def reset
      @xml, @hpricot, @result = nil, nil, nil
    end
  end
end