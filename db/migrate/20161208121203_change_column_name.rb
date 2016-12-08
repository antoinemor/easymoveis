class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :listings, :periode, :period_min
  end
end
