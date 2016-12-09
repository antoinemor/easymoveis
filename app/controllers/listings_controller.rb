class ListingsController < ApplicationController
  before_action :find_listing, only: [:show, :edit, :update, :destroy, :approve_booking, :reject_booking, :rent_booking, :finish_booking]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @results = policy_scope(Listing)
  end

  def show
  end

  def new
    @listing = Listing.new
    @listing.furniture = Furniture.new

    authorize @listing

  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @furniture = Furniture.new(listing_params[:furniture_attributes])
    @furniture.user = current_user
    @listing.furniture = @furniture

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
    @listing.furniture.update(listing_params[:furniture_attributes])
    if @listing.save
      @listing.ambiances.destroy_all
      ambiance_params[:ambiance_ids].each do |ambiance_id|
        next if ambiance_id == ""
        @listing.ambiances << Ambiance.find(ambiance_id)
      end

      redirect_to listing_path(@listing)
    else
      render "new"
    end
  end

  def approve_booking
    @listing.bookings.workflow_step = "A"
    @listing.bookings.save
    current_user.send_message(@listing.bookings.user, "Hey #{@listing.bookings.user.first_name}!\n Congratulations! I have accepted your booking for #{@listing.furniture}! It will be delivered to you soon! \n Cheers! \n #{current_user.first_name}", "Your booking was accepted!")
    redirect_to listing_bookings_path(@listing.id), notice: 'Booking approved.'
  end

  def reject_booking
    @listing.bookings.workflow_step = "R"
    @listing.bookings.save
    current_user.send_message(@listing.bookings.user, "Hey #{@listing.bookings.user.first_name}!\n Unfortunately, I have to reject your booking for #{@listing.furniture}! Sorry about that! \n Thanks! \n #{current_user.first_name}", "Your booking was rejected.")
    redirect_to listing_bookings_path(@listing.id), notice: 'Booking Rejected.'
  end

  def rent_booking
    @listing.bookings.workflow_step = "T"
    @listing.bookings.save
    redirect_to listing_bookings_path(@listing.id), notice: 'The furniture was delivered to the client.'
  end

  def finish_booking
    @listing.bookings.workflow_step = "F"
    @listing.bookings.save
    redirect_to listing_bookings_path(@listing.id), notice: 'The rental operation is finished.'
  end

  private

  def find_listing
    @listing = Listing.find(params[:id])
    authorize @listing
  end

  def listing_params
    params.require(:listing).permit(:base_price, :period_min, :period_max, furniture_attributes: [:name, :description, :category, :listing_id, :user_id, photos: []]).permit!
  end

  def ambiance_params
    params.require(:listing).permit(ambiance_ids: [])
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
end
