module RAAWS
  class Config
    include Singleton
    attr_reader :data, :country
    
    def data=(lang)
      @country = lang
      @data = YAML.load_file( File.dirname(__FILE__) + "/../config.yml" )[lang]
    end
  end
end