class ListingsController < ApplicationController
  before_action :find_listing, only: [:show, :edit, :update, :destroy]
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

  private

  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:base_price, furniture_attributes: [:name, :description, :category, :listing_id, :user_id, photos: []]).permit!
  end

end
