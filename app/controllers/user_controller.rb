class UserController < ApplicationController
  def show
    @user = User.where(username: params[:username])

    @search = User.where("username like ?", "%#{params[:search]}%")

  end
end
