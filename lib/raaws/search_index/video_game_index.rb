module RAAWS
  class MusicIndex < SearchIndex
    AUTHORIZED_PARAMS = %w<
      Artist Availability BrowseNode Count
      Format ItemPage Keywords Magazines MusicLabel 
      Performer PostalCode Publisher Sort State Title>
    
  end
end  