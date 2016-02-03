class UserController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers]

  def show
  end

  def following
  end

  def followers
  end

  private
  def set_user
    @user = User.where(username: params[:username]).first
  end
end
