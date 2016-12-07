class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :edit, :update, :destroy, :approve_booking, :reject_booking, :cancel_booking]
  before_action :get_listing, only: [:show, :edit, :approve_booking, :reject_booking]
  before_action :find_listing, only: [:new, :create, :index, :update, :destroy]

  def index
    @bookings = @listing.bookings

  end

  def show
  end

  # GET /bookings/new
  def new
    @booking = @listing.bookings.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
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

  # PATCH/PUT /bookings/1
  def update
    @booking.status = "E"
    @booking.update(booking_params)
    redirect_to user_booking_list_path(@booking.id, @booking.listing_id), notice: 'Booking was successfully updated.'

  end

  def cancel_booking
    @booking.update_attributes(status: "C")
    redirect_to user_booking_list_path(@booking.id, @booking.listing_id), notice: 'Booking was successfully cancelated.'
  end

  # DELETE /bookings/1
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
    redirect_to listing_bookings_path(@booking.listing_id), notice: 'Booking acceped.'
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

    def find_listing
      @listing = listing.find(params[:listing_id])

    end

    def get_listing

      @listing = @booking.listing

    end

    # Use callbacks to share common setup or constraints between actions.
    def find_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:check_in, :check_out, :status, :user_id, :listing_id)
    end

end
