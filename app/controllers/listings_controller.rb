class ListingsController < ApplicationController
  before_action :find_listing, only: [:show, :edit, :update, :destroy, :approve_booking, :reject_booking, :rent_booking, :finish_booking]
  skip_before_action :authenticate_user!, only: [:index, :show, :search]

  def search
    @results = Listing.available(current_user)
    authorize @results
    @hash = Gmaps4rails.build_markers(@results) do |result, marker|
      marker.lat result.address.latitude
      marker.lng result.address.longitude
      # marker.infowindow render_to_string(partial: "/results/map_box", locals: { result: result })
    end
  end

  def index
    params['option'].present? ? option = params['option'] : option = "available"
    @listings = list_by_action(option, policy_scope(Listing))
  end

  def show
    @results = policy_scope(Listing)
    @hash = Gmaps4rails.build_markers(@listing) do |result, marker|
      marker.lat result.address.latitude
      marker.lng result.address.longitude
      # marker.infowindow render_to_string(partial: "/results/map_box", locals: { result: result })
    end
  end

  def new
    @listing = Listing.new
    @listing.furniture = Furniture.new
    @listing.address = Address.new

    authorize @listing
  end

  def create
    @listing = Listing.create(listing_params)
    @listing.user = @listing.furniture.user = current_user
    authorize @listing
    if @listing.save
      ambiance_params[:ambiance_ids].each do |ambiance_id|
        next if ambiance_id == ""
        @listing.ambiances << Ambiance.find(ambiance_id)
      end
      redirect_to listing_path(@listing)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @listing.update(listing_params)
    if @listing.save
      @listing.ambiances.destroy_all
      ambiance_params[:ambiance_ids].each do |ambiance_id|
        next if ambiance_id == ""
        @listing.ambiances << Ambiance.find(ambiance_id)
      end
      redirect_to listing_path(@listing)
    else
      render "edit"
    end
  end

  def approve_booking
    @listing.bookings[0].workflow_step = "A"
    @listing.bookings[0].save
    if @listing.bookings.first.delivery.partner_delivery
      delivery_message = "You chose EasyMoveis partner delivery, and your furniture will be assigned to a delivery partner shortly."
    else
      delivery_message = "When are you available to come and pick it up?"
    end
    current_user.send_message(@listing.bookings[0].user,
      "Hello #{@listing.bookings[0].user.first_name}!\n I just approved your booking for #{@listing.furniture.name}! #{delivery_message}\n",
     "Your booking was approved")
    redirect_to listings_path, notice: 'The booking was approved and the user has been informed.'
  end

  def reject_booking
    @listing.bookings[0].workflow_step = "R"
    @listing.bookings[0].save
    redirect_to reject_booking_message_path(@listing.id)
  end

  def rent_booking
    @listing.bookings[0].workflow_step = "T"
    @listing.bookings[0].save
    current_user.send_message(@listing.bookings[0].user, "Hello #{@listing.bookings[0].user.first_name}!\n Your furniture: #{@listing.furniture.name} was delivered!", "Booking delivered")
    redirect_to listings_path, notice: 'The furniture was delivered to the client.'
  end

  def finish_booking
    @listing.bookings[0].workflow_step = "F"
    @listing.bookings[0].save
    current_user.send_message(@listing.bookings[0].user, "Hello #{@listing.bookings[0].user.first_name}!\n Your booking: #{@listing.furniture.name} was finished!", "Booking Finished")
    redirect_to listings_path, notice: 'The rental operation is finished.'
  end

  private

  def list_by_action(option, listings)
    case option
      when 'available'
        results = listings.select do |listing|
          listing.bookings.empty? == true
        end
      when 'pending'
        results = listings.select do |listing|
          listing.bookings.empty? == false && (listing.bookings[0].workflow_step == 'P' || listing.bookings[0].workflow_step == 'R')
        end
      when 'waiting'
        results = listings.select do |listing|
          listing.bookings.empty? == false && (listing.bookings[0].workflow_step == 'A')
        end
      when 'rented'
        results = listings.select do |listing|
          listing.bookings.empty? == false && (listing.bookings[0].workflow_step == 'T')
        end
      when 'finished'
        results = listings.select do |listing|
          listing.bookings.empty? == false && (listing.bookings[0].workflow_step == 'F')
        end
    end
    return results
  end

  def find_listing
    @listing = Listing.find(params[:id])
    authorize @listing
  end

  def listing_params
    params.require(:listing).permit(:base_price, :deposit, :ambiance_id, :period_min, :period_max, furniture_attributes: [:name, :description, :category, :listing_id, :user_id, photos: []], address_attributes: [:address_line, :city, :zip_code, :country, :latitude, :longitude]).permit!
  end

  def ambiance_params
    params.require(:listing).permit(ambiance_ids: [])
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
end
