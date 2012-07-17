module RAAWS
  class DVDIndex < SearchIndex
    AUTHORIZED_PARAMS = %w<
      Actor AudienceRating Availability BrowseNode 
      Count Director Format ItemPage Keywords 
      Magazines Performer PostalCode Publisher 
      Sort State Title>
            
  end
end  