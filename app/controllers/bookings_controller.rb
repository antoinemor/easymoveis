class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update, :destroy, :cancel_booking]
  before_action :get_listing, only: [:show, :edit]
  before_action :find_listing, only: [:new, :create, :update]
  before_action :get_furniture, only: [:new]

  def index
    @bookings = policy_scope(Booking)
  end

  def show
  end

  def new
    if current_user.bookings.where(listing_id: (params[:listing_id]) ).present?
      redirect_to listing_path(params[:listing_id]), alert: 'This listing is already booked.'
    end

    @booking = @listing.bookings.new
    authorize @booking
  end

   def create
    @booking = @listing.bookings.new(booking_params)
    @booking.workflow_step = "P"
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to bookings_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @booking.workflow_step = "P"
    authorize @booking
    @booking.update(booking_params)
    redirect_to bookings_path, notice: 'Booking was successfully updated.'
  end

  def destroy
    @booking.destroy
      redirect_to bookings_path, notice: 'Booking was successfully canceled.'
  end

  private

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end

  def get_listing
    @listing = @booking.listing
  end

  def get_furniture
    @furniture = @listing.furniture
  end

  def find_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:end_date, :start_date, :workflow_step, :user_id, :listing_id)
  end
end

