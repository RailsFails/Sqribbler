class CreateAlbumEntries < ActiveRecord::Migration
  def change
    create_table :album_entries do |t|
      t.references :image, index: true, foreign_key: true
      t.references :album, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
