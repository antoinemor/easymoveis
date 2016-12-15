class SearchController < ApplicationController
  def index
    @listings = Listing.global_search("#{params[:furniture][:furniture_type]} #{params[:city]}")

    @max_price = Listing.max_price

    @listings = @listings.where("base_price >= ?", params[:price_min]) if params[:price_min].present?
    @listings = @listings.where("base_price <= ?", params[:price_max]) if params[:price_max].present?

    @listings = @listings.select{|l| l.ambiances.map(&:name).include?(params[:ambiance_name])} if params[:ambiance_name].present?

    @hash = Gmaps4rails.build_markers(@listings) do |result, marker|
      marker.lat result.address.latitude
      marker.lng result.address.longitude
      marker.picture({
                  :url => view_context.cl_image_path("uu6v7azx9zx50he4wfl2", width: 42, height: 42, crop: :fill),
                  :width   => 42,
                  :height  => 42
                 })
      marker.infowindow render_to_string(partial: "/search/map_box", locals: { result: result })
    end
  end
end
