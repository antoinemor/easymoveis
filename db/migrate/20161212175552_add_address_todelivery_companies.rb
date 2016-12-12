class AddAddressTodeliveryCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :delivery_companies, :address, :text
  end
end
