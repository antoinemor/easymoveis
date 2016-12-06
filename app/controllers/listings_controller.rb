class ListingsController < ApplicationController
  before_action :find_listing only: [:new, :create, :index, :update, :destroy]

  def index
    @results = listings.furnitures.where(type: params[:type])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    #@listing.furniture = @furniture
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render "new"
    end
  end

  def edit
  end

  def show
  end

  def update
  end

private



  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:base_price, :furniture, photos: [])
  end

end
