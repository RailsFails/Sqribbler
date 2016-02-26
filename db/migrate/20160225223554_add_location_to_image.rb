class AddLocationToImage < ActiveRecord::Migration
  def change
    add_column :images, :latitude, :float, precision: 10, scale: 6
    add_column :images, :longitude, :float, precision: 10, scale: 6
  end
end
