class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.integer :access

      t.timestamps null: false
    end
    add_index :albums, :title
  end
end
