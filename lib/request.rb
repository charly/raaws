module RAAWS
  class Request
    attr_reader :params
    
		def initialize
			@base_url = "http://ecs.amazonaws.com"
			@params = {
        :service => "AWSECommerceService",
        :a_w_s_access_key_id => "1GGP2X6SNBRNARDHET82",
        :associate_tag => "charliechap0e-20",
        :operation => "ItemSearch",
        :version => "2008-10-07",
        :item_page => "1",
        :search_index => "DVD",
        :response_group => "Small",
      }
		end
		
		def params=(arg)
		  @params.update(arg)
	  end
	  
	  def camelize_hash_keys(arg={})
	    returning Hash.new do |a|
  	    arg.map { |k,v| a[k.to_s.camelize] = v }
	    end
    end
    
    def uri
      @uri = URI.join(@base_url, "/onca/xml")
      @uri.query = camelize_hash_keys(@params).
        map { |k,v| "%s=%s" % [URI.encode(k), URI.encode(v)] }.
        join("&") 
      @uri
    end
    
    def send
      open(self.uri)
    end	  
	end
end