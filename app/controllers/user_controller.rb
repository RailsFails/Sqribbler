class UserController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers, :mutual_friends, :message]

   def user_profile_update
     current_user.update(user_params)

     current_user.save
     redirect_to user_profile_path(current_user.username), notice: 'User was successfully updated.'

   end

  def show
    #@user = User.find(params[:id])
  end

  def following
  end

  def followers
  end

  def message_friend
    @user = User.where.not('id = ?',current_user.id).order('created_at DESC')
    @conversations = Conversation.involving(current_user).order('created_at DESC')
  end

  def mutual_friends
    @friend = User.where(username: params[:friend_username]).first
    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to landing_page_index_path, notice: 'User was successfully Signed Out.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.where(username: params[:username]).first
    if @user.nil?
      render :text => 'User not found', :status => '404'
    end
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :username, :email, :phone_number, :location, :about_me, :avatar)
  end
end
