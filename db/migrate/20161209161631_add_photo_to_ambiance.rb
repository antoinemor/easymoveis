class AddPhotoToAmbiance < ActiveRecord::Migration[5.0]
  def change
    add_column :ambiances, :photo, :string
  end
end
