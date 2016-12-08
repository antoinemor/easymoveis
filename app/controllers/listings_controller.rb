class ListingsController < ApplicationController
  before_action :find_listing, only: [:show, :edit, :update, :destroy, :approve_booking, :reject_booking, :rent_booking, :finish_booking]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # city = params[:city]
    # furniture_type = params[:furniture_type]
    # @results = Listings.where(city: city, furniture_type: furniture_type)
    @results = Listing.all
  end

  def user_listings
    @listings = current_user.listings
  end

  def new
    @listing = Listing.new
    @listing.furniture = Furniture.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @furniture = Furniture.new(listing_params[:furniture_attributes])
    @furniture.user = current_user
    @listing.furniture = @furniture
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @listing.update(base_price: listing_params[:base_price])
    @listing.furniture.update(listing_params[:furniture_attributes])
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render "new"
    end
  end

  def show
  end

  # Booking was approved and the furniture is waiting for deliver
  def approve_booking
    @listing.bookings.workflow_step = "A"
    @listing.bookings.save
    redirect_to listing_bookings_path(@listing.id), notice: 'Booking approved.'
  end

  def reject_booking
    @listing.bookings.workflow_step = "R"
    @listing.bookings.save
    redirect_to listing_bookings_path(@listing.id), notice: 'Booking Rejected.'
  end

  def rent_booking
    @listing.bookings.workflow_step = "T"
    @listing.bookings.save
    redirect_to listing_bookings_path(@listing.id), notice: 'The furniture was delivered to the client.'
  end

  # The rental contract is finished
  def finish_booking
    @listing.bookings.workflow_step = "F"
    @listing.bookings.save
    redirect_to listing_bookings_path(@listing.id), notice: 'The rental operation is finished.'
  end

  private

  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:base_price, furniture_attributes: [:name, :description, :category, :listing_id, :user_id, photos: []]).permit!
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end


end
