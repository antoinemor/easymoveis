class AddDepositToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :deposit, :integer
  end
end
