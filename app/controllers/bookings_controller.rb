class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update, :destroy, :approve_booking, :reject_booking, :cancel_booking]
  before_action :get_listing, only: [:show, :edit, :approve_booking, :reject_booking]
  before_action :find_listing, only: [:new, :create, :index, :update, :destroy]

  def index
    @bookings = @user.bookings
  end

  def show
  end

  def new
    @booking = @listing.bookings.new
  end

   def create
    @booking = @listing.bookings.new(booking_params)
    @booking.status = "E"
    @booking.user = current_user
    if @booking.save
      redirect_to user_booking_list_path(@booking.id, @booking.listing), notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @booking.status = "E"
    @booking.update(booking_params)
    redirect_to user_booking_list_path(@booking.id, @booking.listing_id), notice: 'Booking was successfully updated.'
  end

  def cancel_booking
    @booking.update_attributes(status: "C")
    redirect_to user_booking_list_path(@booking.id, @booking.listing_id), notice: 'Booking was successfully cancelated.'
  end

  def destroy
    @booking.destroy
      redirect_to bookings_url, notice: 'Booking was successfully destroyed.'
  end

  def list_users
    @user = User.find(current_user)
    @bookings = @user.bookings
  end

  def approve_booking
    @booking.status = "A"
    @booking.save
    redirect_to listing_bookings_path(@booking.listing_id), notice: 'Booking accepted.'
  end

  def reject_booking
    if @booking.status == "A"
      @booking.listing.vacancies += 1
      @listing.save
    end

    @booking.status = "R"
    @booking.save
    redirect_to listing_bookings_path(@booking.listing_id), notice: 'Booking Rejected.'
  end

  private

  # List bookings by workflow step
  def list_booking_by_step(step)
    @bookings = user.bookings.where(workflow_step: step)
  end

  def find_listing
    @listing = listing.find(params[:listing_id])
  end

  def get_listing
    @listing = @booking.listing
  end

  # Get furniture data linked to listing
  def get_furniture
    @furniture = @booking.furniture
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:end_date, :start_date, :workflow_step, :user_id, :listing_id)
  end
end

