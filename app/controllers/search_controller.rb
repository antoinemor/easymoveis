class SearchController < ApplicationController
  def index
    @listings = Listing.global_search("#{params[:furniture_type]} #{params[:city]}")
  end
end
