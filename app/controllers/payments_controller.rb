class PaymentsController < ApplicationController
  before_action :set_booking

  def new
    delivery_cost = 0
    if @booking.delivery.partner_delivery
      delivery_cost = @booking.delivery.delivery_price
    end
    @total_price = @booking.listing.deposit + @booking.price + delivery_cost
  end

  def create
    delivery_cost = 0
    if @booking.delivery.partner_delivery
      delivery_cost = @booking.delivery.delivery_price
    end
    @total_price = @booking.listing.deposit + @booking.price + delivery_cost
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @total_price, # or amount_pennies
      description:  "Payment for #{@booking.listing.furniture.name} rental %>",
      currency:     'USD'
    )

    @booking.update(payment: charge.to_json)
    redirect_to listing_booking_path(@booking.listing, @booking)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_listing_booking_payment_path(@booking.listing, @booking)
  end


private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end
end
