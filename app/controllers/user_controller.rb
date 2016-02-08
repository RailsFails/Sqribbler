class UserController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers, :mutual_friends]

  def user_profile_edit
    @user = User.new(user_params)
    @user.save
    redirect_to user_profile_path(@user.username)
    # if( current_user.save())
    # return
    # else
    #
  end


  # @user_id = params[:user_id]
  # @first_name = params[:first_name]
  # @last_name = params[:last_name]
  # @username = params[:username]
  # @email = params[:email]
  # @phone_number = params[:phone_number]
  # @location = params[:location]
  # @about_me = params[:about_me]
  # @profile_avatar = params[:profile_avatar]

  def show
    #@user = User.find(params[:id])
  end

  def following
  end

  def followers
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
      format.html { redirect_to landing_page_index_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.where(username: params[:username]).first
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :username, :email, :phone_number, :location, :about_me, :profile_avatar)
  end
end
