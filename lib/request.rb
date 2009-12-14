module RAAWS          
  class Request
    #attr_reader :params
    
		def initialize(params={})
		  @config = RAAWS::Config.instance
			@domain = @config.data[:domain]
			@associate_tag = @config.data[:associate_tag]
			@secret_key = @config.data[:secret_key]
			
			@params = params
			self.params = {
        :service => "AWSECommerceService",
        :associate_tag => @associate_tag,
        :a_w_s_access_key_id => "1GGP2X6SNBRNARDHET82",
        :version => "2009-01-06"
      }
		end
		
		# TODO : shoulda work with arguments
		module Params
  		# TODO : change API here, not very clear
  		# gather all the params with this method
  		def params=(params)
  		  @params.update(params)
  	  end
  	  
  	  def params() @params; end
  	  
  	  # from {:title => "Kid"} to
  	  # {:title=>"Kid", :timestamp => "2009-09-22T12:05:39+02:00"}
  	  def add_timestamp_to_params(params)
  	    params.update({:timestamp => Time.now.iso8601 })
  	  end
  	  
  	  # from {:access_key => "blabla"} to {"AccessKey" => "blabla"}
  	  def camelize_params(params)
  	    returning Hash.new do |a|
    	    params.map { |k,v| a[k.to_s.camelize] = v }
  	    end
      end
  	   	  
  	  # from {:title => "Modern Times"} to {:title=>"Modern%20Times"}
 	    def encode_params(params)
	      returning Hash.new do |a|
  	      params.map { |k, v| a[k] = url_encode(v)  }	       
	      end
      end
      
  	  # TODO : consider returning OrderedHash instead of [[k, v],[k, v]]
  	  # sort byte wise (alphabetically puts capitals first)
  	  def sort_params(params)
  	    params.keys.sort.map { |k| [k, params[k]]  }
	    end
	    	  
	  end
	  include Params
	  
	  module URLString
	    # Insist on specific method of URL encoding, RFC3986. 
      def url_encode(string)
        return CGI.escape(string).gsub("%7E", "~").gsub("+", "%20").gsub(/:/, "%3A")
      end
      
      # from {"Title"=>"Kid", "Author" => "chaplin"} to
      # Title=Kid&Author=chaplin
      def params_to_string(ordered_params)
        ordered_params.map { |a| a.join("=") }.join('&')
      end
      
      # Amazon rest authentication
      def string_for_signature(ordered_params_string)
%Q(GET
#{@domain}
/onca/xml
#{ordered_params_string})
      end
      
      # Amazon rest authentication
      def signature(string_for_signature)
        hmac = HMAC::SHA256.new( @secret_key )
        hmac.update( string_for_signature )
        # chomp is important!  the base64 encoded version will have a newline at the end
        @signature = Base64.encode64(hmac.digest).chomp
      end
      
    end
	  include URLString
	  
	  # getting params ready to get 'stringed'
	  def process_params
	    p = add_timestamp_to_params(@params)
	    p = camelize_params(p)
	    encode_params(p)
    end
    
    # constructs the hole thing!
    def process_url_string
      uri = params_to_string( sort_params(process_params) )
      s = string_for_signature(uri)
      s = signature(s)
      uri = uri + '&' + 'Signature=' + url_encode(s)
    end
	  
	  
    def uri
      @uri ||= "http://" + @domain + '/onca/xml?' + process_url_string
    end
    
    def get
      #Net::HTTP.get uri
      open( uri )
    end	  
	
	end
end