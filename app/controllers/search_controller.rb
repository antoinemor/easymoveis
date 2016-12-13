class SearchController < ApplicationController
  def index
    @listings = Listing.global_search("#{params[:furniture][:furniture_type]} #{params[:city]}")

    @listings = @listings.where("base_price >= ?", params[:price_min]) if params[:price_min].present?
    @listings = @listings.where("base_price <= ?", params[:price_max]) if params[:price_max].present?

    @listings = @listings.select{|l| l.ambiances.map(&:name).include?(params[:ambiance_name])} if params[:ambiance_name].present?

    @hash = Gmaps4rails.build_markers(@listings) do |result, marker|
      marker.lat result.address.latitude
      marker.lng result.address.longitude
      # marker.infowindow render_to_string(partial: "/results/map_box", locals: { result: result })
    end
  end
end
