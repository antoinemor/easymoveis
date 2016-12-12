class ChangeAddressNameInAddresses < ActiveRecord::Migration[5.0]
  def change
    rename_column :addresses, :address, :address_line
  end
end
