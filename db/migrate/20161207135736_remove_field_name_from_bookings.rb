class RemoveFieldNameFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :status, :string
  end
end
