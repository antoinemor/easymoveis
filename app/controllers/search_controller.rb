class SearchController < ApplicationController
  def index
    @listings = Listing.global_search("#{params[:furniture_type]} #{params[:city]}")
    @hash = Gmaps4rails.build_markers(@listings) do |result, marker|
      marker.lat result.address.latitude
      marker.lng result.address.longitude
      # marker.infowindow render_to_string(partial: "/results/map_box", locals: { result: result })
    end
  end
end
