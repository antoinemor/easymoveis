class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update, :destroy, :approve_booking, :reject_booking, :cancel_booking]
  before_action :get_listing, only: [:show, :edit, :approve_booking, :reject_booking]
  before_action :find_listing, only: [:new, :create, :index, :update, :destroy]
  before_action :get_furniture, only: [:new]

  def index
    @bookings = Listing.find(params[:listing_id]).bookings
  end

  # List all user's bookings
  def user_bookings
    @bookings = current_user.bookings
  end

  def show
  end

  def new
    # first it's necessary check if the listing is already booked to the user
    if current_user.bookings.where(listing_id: (params[:listing_id]) ).present?
      redirect_to listing_path(params[:listing_id]), alert: 'This listing is already booked.'
    end

    @booking = @listing.bookings.new
  end

   def create
    @booking = @listing.bookings.new(booking_params)
    @booking.workflow_step = "E"
    @booking.user = current_user
    if @booking.save
      redirect_to user_bookings_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @booking.workflow_step = "E"
    @booking.update(booking_params)
    redirect_to user_bookings_path, notice: 'Booking was successfully updated.'
  end

  def cancel_booking
    @booking.update_attributes(workflow_step: "C")
    redirect_to user_bookings_path, notice: 'Booking was successfully cancelated.'
  end

  def destroy
    @booking.destroy
      redirect_to bookings_url, notice: 'Booking was successfully destroyed.'
  end

  private

  # List bookings by workflow step
  def list_booking_by_step(step)
    @bookings = user.bookings.where(workflow_step: step)
  end

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end

  def get_listing
    @listing = @booking.listing
  end

  # Get furniture data linked to listing
  def get_furniture
    @furniture = @listing.furniture
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:end_date, :start_date, :workflow_step, :user_id, :listing_id)
  end
end

