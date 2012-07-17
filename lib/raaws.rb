
# STANDARD
require "singleton"
require 'ostruct'
require "open-uri"
require "net/http"
require "uri"
require "fileutils"
require 'cgi'
require 'time'
require 'hmac'
require 'hmac-sha2'
require 'base64'

#EXTERNAL
require "active_support"
require "nokogiri"


# INTERNAL
require "raaws/config"
require "raaws/request"
require "raaws/response"
require "raaws/operation"
require "raaws/operation/item_operation"
require "raaws/search_index/search_index"
require "raaws/search_index/books_index"
require "raaws/search_index/classical_index"
require "raaws/search_index/d_v_d_index"
require "raaws/search_index/music_index"


module RAAWS
  DEFAULT_PARAMS = {
    :service => "AWSECommerceService",
    :a_w_s_access_key => "charliechap0e-20",
    :associate_tag => "1GGP2X6SNBRNARDHET82",
    :operation => "ItemSearch",
    :version => "2008-10-07",
    :item_page => "1",
    :search_index => "DVD",
    :response_group => "Small",
    :author => "Charlie Chaplin"
  }   
   
  # TODO : complete list
  RESPONSE_GROUP = %w<  
    Accessories AlternateVersions BrowseNodeInfo BrowseNodes
    Cart CartNewReleases CartToSellers CartSimilarites Collections
    CustomerFull CustomerInfo CustomerLists CustomerReviews
    EditorialReview Fitments HasPartCompatibility Help 
    Images ItemAttributes ItemIds 
    Large ListFull
    Medium
    NewReleases
    OfferFull
    PartBrandBinsSummary
    RelatedItems
    Small
    Tags
    VariationMinimum>
end