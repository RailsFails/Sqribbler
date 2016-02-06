class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provile_avatar, :text
  end
end
