class UserController < ApplicationController
  def show
    @user = User.where(username: params[:username])
  end
end
