class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_avatar, :text
  end
end
