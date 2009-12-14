module RAAWS
  class Config
    include Singleton
    attr_reader :data
    
    def data=(lang)
      @data = YAML.load_file( File.dirname(__FILE__) + "/../config.yml" )[lang]
    end
  end
end