class AddFieldnameToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :workflow_step, :string
  end
end
