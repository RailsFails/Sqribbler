class UserController < ApplicationController

  def user_profile_edit
    @user_id = params[:user_id]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @username = params[:username]
    @email = params[:email]
    @phone_number = params[:phone_number]
    @location = params[:location]
    @about_me = params[:about_me]
    @profile_avatar = params[:profile_avatar]
  end

  def show
    @user = User.where(username: params[:username]).first
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to landing_page_index_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:user_id, :first_name, :last_name, :username, :email, :phone_number, :location, :about_me, :profile_avatar)
  end

end
