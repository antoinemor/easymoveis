class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    current_user.address = Address.create(address_params)
    redirect_to edit_user_registration_path, notice: 'Address was successfully updated.'
  end

  private

  def address_params
    params.require(:address).permit(:address_line, :city, :zip_code, :country)
  end
end
