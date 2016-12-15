class AddPaymentToBooking < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :payment, :json
  end
end
