module RAAWS
  class Config
    include Singleton
    attr_accessor :lang, :data
    
    FR = {
      :domain => "webservices.amazon.fr",
      :associate_tag => "charlieschapl-21",
      :secret_key => 'secretekeyfromamazonwhydotheyneedthat'
      }
      
    US = {
      :domain => "webservices.amazon.com",
      :associate_tag => "charliechap0e-20",
      :secret_key => 'secretkeyfromamazonwhydotheyneedthat'      
    }
    
    def lang=(lang)
      @lang = lang
      @data = @lang=="fr" ? FR : US
    end
  end
end