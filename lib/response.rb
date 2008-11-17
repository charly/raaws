module RAAWS
  
  class SearchResults < OpenStruct; end
  
  class Response
    attr_accessor :group, :xml, :hpricot
        
    def hpricot=(xml)
      @hpricot = Hpricot::XML(xml)
    end
    
    def items(reload= false)
      @items ||= (@hpricot/'Item').inject([]) do |collection, item|
        collection << new_from_element(item)
      end
    end
    
    # NOTE : copied from AAWS
    def new_from_element(element)
      obj = OpenStruct.new
      obj.asin = element.at('ASIN').innerHTML
      obj.url = element.at('DetailPageURL').innerHTML
      
      # auto create methods for each of the item attributes
      element.at('ItemAttributes').children.each do |child|
        if child.respond_to?(:stag)
          attr = child.stag.name.underscore
          obj.send("#{attr}=", child.innerHTML) unless %w[asin url].include?(attr)
        end
      end
      return obj
    end 
    
  end
end

