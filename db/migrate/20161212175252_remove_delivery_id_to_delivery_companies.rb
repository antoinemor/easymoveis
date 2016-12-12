class RemoveDeliveryIdToDeliveryCompanies < ActiveRecord::Migration[5.0]
  def change
    remove_column :delivery_companies, :delivery_id, :string
  end
end
