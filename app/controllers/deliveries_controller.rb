class DeliveriesController < ApplicationController
  before_action :find_delivery, only: [:show, :accept]

  def index
    @deliveries = Delivery.where(partner_delivery: true, status: 'P')
  end

  def show
  end

  def accept
    @delivery.booking.listing.user.send_message(@delivery.booking.user, "Hey #{@delivery.booking.user.first_name}! \n Your furniture is on its way and will be delivered by #{current_user.name}. Cheers!", "It's coming!")
    @delivery.status = 'D'
    @delivery.save
    render 'show'
  end

  private

  def find_delivery
    @delivery = Delivery.find(params[:id])
  end
end
