class AddPartnerDeliveyAndDeliveryPriceToDelivery < ActiveRecord::Migration[5.0]
  def change
    add_column :deliveries, :partner_delivery, :boolean
    add_column :deliveries, :delivery_price, :integer
  end
end
