class AdddeliveryCompanieIdTodeliveries < ActiveRecord::Migration[5.0]
  def change
    add_column :deliveries, :delivery_companie_id, :integer
  end
end
