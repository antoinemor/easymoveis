class BookingsController < ApplicationController
  before_action :find_booking,  only: [:show, :edit, :update, :destroy, :cancel_booking]
  before_action :get_listing,   only: [:show, :edit]
  before_action :find_listing,  only: [:new, :create, :update]
  before_action :get_furniture, only: [:new, :edit]

  def index
    params['option'].present? ? option = params['option'] : option = "pending"
    @bookings = list_by_action(option, policy_scope(Booking))
  end

  def show
  end

  def new
    if current_user.bookings.where(listing_id: (params[:listing_id]) ).present?
      redirect_to listing_path(params[:listing_id]), alert: 'This listing is already booked.'
    end
    unless params[:booking][:duration].present?
      redirect_to listing_path(params[:listing_id]), alert: 'Please inform rental duration.'
    end
    @price = params[:booking][:price].to_i
    @duration = params[:booking][:duration].to_i
    @booking = @listing.bookings.new
    @booking.build_delivery
    authorize @booking
  end

   def create
    @booking = @listing.bookings.new(booking_params)
    @booking.delivery.status = "P"
    @booking.workflow_step = "P"
    @booking.user = current_user
    authorize @booking
    if @booking.save
      current_user.send_message(@listing.user, "Hey #{@listing.user.first_name}!\n I want to book #{@listing.furniture.name}! Please accept my demand as soon as possible! \n Cheers! \n #{current_user.first_name}", "You have a new booking!")
      redirect_to new_listing_booking_payment_path(@booking.listing, @booking), notice: 'Your booking was successfully created.'
    else
      @price = booking_params[:price].to_i
      @duration = booking_params[:duration].to_i
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
      redirect_to root_path, notice: 'Booking was successfully canceled.'
  end

  private

  def list_by_action(option, bookings)
    case option
      when 'pending'
        results = bookings.select do |booking|
          booking.nil? == false && (booking.workflow_step == 'P' || booking.workflow_step == 'R')
        end
      when 'waiting'
        results = bookings.select do |booking|
          booking.nil? == false && (booking.workflow_step == 'A')
        end
      when 'rented'
        results = bookings.select do |booking|
          booking.nil? == false && (booking.workflow_step == 'T')
        end
      when 'finished'
        results = bookings.select do |booking|
          booking.nil? == false && (booking.workflow_step == 'F')
        end
    end
    return results
  end

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
    params.require(:booking).permit(:end_date, :start_date, :workflow_step, :price, :duration, :user_id, :listing_id, delivery_attributes: [:partner_delivery, :delivery_price])
  end
end

