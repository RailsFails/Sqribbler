class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :item_type
      t.references :item, polymorphic: true, index: true
      t.references :user, index: true, foreign_key: true
      t.string :ip_address
      t.string :reason
      t.text :comment

      t.timestamps null: false
    end
    add_index :reports, :item_type
  end
end
