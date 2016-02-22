class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :item_id
      t.string :item_type
      t.integer :value

      t.timestamps null: false
    end

    add_index :votes, [:item_id, :item_type]
  end
end
