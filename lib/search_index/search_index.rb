module RAAWS
  SEARCH_INDEX = %w<
    All Apparel Automotive Baby Beauty Blended Books 
    Classical DVD DigitalMusic Electronics GourmetFood Grocery
    HealthPersonalCare HomeGarden Industrial Jewelry KindleStore
    Kitchen MP3Downloads Magazines Marketplace Merchants
    Miscellaneous Music MusicTracks MusicalInstruments OfficeProducts
    OutdoorLiving PCHardware PetSupplies Photo
    SilverMerchants Software SportingGoods Tools Toys UnboxVideo
    VHS Video VideoGames Watches Wireless WirelessAccessories>
    
  class SearchIndex < OpenStruct
    alias :to_params :marshal_dump
    
    def initialize
      super
      self.search_index = self.class.to_s.split("::").last.gsub(/Index/, '')
    end
    
    # def instance_variables_to_hash
    #   returning Hash.new do |params|
    #     instance_variables.map { |i| params[i.gsub(/^@/, '').to_sym] = instance_variable_get(i)  }
    #   end
    # end
    # alias :to_params :instance_variables_to_hash
  end
end
