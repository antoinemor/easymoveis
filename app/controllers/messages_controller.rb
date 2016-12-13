class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end

  def new_to
    @user = User.find(params[:user_id])
  end

  # def create_to(user)
  #   conversation = current_user.send_message(user, params[:message][:body], params[:message][:subject]).conversation
  #   flash[:success] = "Message has been sent!"
  #   redirect_to conversation_path(conversation)
  # end
end
