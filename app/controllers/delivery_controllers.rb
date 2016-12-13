class DeliveryController < ApplicationController
  def itinerary(delivery)
    start_address = delivery.user.address
    end_address = delivery.listing.address
  end
end
