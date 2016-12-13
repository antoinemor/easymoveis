class AmbiancesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @ambiance = Ambiance.find(params[:ambiance_id])
    @listings = Listing.all.select { |l| l.ambiances.include?(@ambiance) }
    @hash = Gmaps4rails.build_markers(@listings) do |result, marker|
      marker.lat result.address.latitude
      marker.lng result.address.longitude
      # marker.infowindow render_to_string(partial: "/results/map_box", locals: { result: result })
    end
    render 'search/index'
  end
end
