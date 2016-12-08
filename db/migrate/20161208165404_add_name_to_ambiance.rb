class AddNameToAmbiance < ActiveRecord::Migration[5.0]
  def change
    add_column :ambiances, :name, :string
  end
end
