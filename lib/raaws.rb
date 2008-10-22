$:.unshift File.join(File.dirname(__FILE__),'lib')
require "rubygems"
require 'ostruct'
require "hpricot"
require "open-uri"
require "uri"
require "fileutils"
require "active_support"


module RAAWS
  require "request"
  require "response"
  require "operation/operation"
  require "operation/item_operation"
  require "search_index/search_index"
  require "search_index/books_index"
  require "search_index/classical_index"
  require "search_index/d_v_d_index"
  require "search_index/music_index"
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