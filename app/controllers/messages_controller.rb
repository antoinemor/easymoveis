class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_listing, only: [:reject_booking, :send_reject_message]

  def new
  end

  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end

  def reject_booking
  end

  def send_reject_message
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(@listing.bookings[0].user, params[:message][:body], "Booking was rejected by the Owner").conversation
    flash[:success] = "Message has been sent!"
    redirect_to listings_path

  end


  private


  def message_params
    params.require(:listing).permit(:listing_id)
  end


  def find_listing
    @listing = Listing.find(params[:listing_id])
  end

end
