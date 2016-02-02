class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to user_profile_path(@friendship.friend.username)
    else
      flash[:notice] = "Unable to add friend."
      redirect_to user_profile_path(@friendship.friend.username)
    end
  end

  def destroy
    @friendship = current_user.friendships.where(:friend_id => params[:id]).first
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to user_profile_path(@friendship.friend.username)
  end
end
