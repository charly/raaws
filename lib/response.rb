module RAAWS
  
  class SearchResults < OpenStruct; end
  
  class Response
    attr_accessor :group, :xml, :hpricot
        
    def hpricot=(xml)
      @hpricot= Nokogiri::XML(xml)
    end
    
    def items(reload= false)
      @items ||= (@hpricot/'Item').inject([]) do |collection, item|
        collection << new_from_element(item)
      end
    end
    
    # NOTE : copied from AAWS
    def new_from_element(element)
      returning OpenStruct.new do |obj|
        obj.asin = element.at('ASIN').inner_text
        obj.url = element.at('DetailPageURL').inner_text
        obj.title = element.at("Title").inner_text
      end
    end
  end
end

