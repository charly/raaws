module RAAWS
  class Config
    include Singleton
    attr_reader :data, :country
    attr_accessor :service, :domain, :associate_tag, :secret_key, :version
    
    #{'us'=> {'domain'=> "fjkjdfngj"}}
    # or 'us' & loads raaws.yaml file
    def data=(lang)
      if lang.is_a?(Hash)
        @country = lang.keys.first
        @data = lang
      else
        @data = YAML.load_file(File.join Rails.root, "config", "raaws.yml")[lang]
      end
    end
  end
end