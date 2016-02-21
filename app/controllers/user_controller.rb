class UserController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers, :mutual_friends, :message]

  def user_profile_update
    current_user.update(user_params)

    #respond_to do |format|
    #if  @user.save
    #format.html { redirect_to user_profile_path(@user), notice: 'User was successfully updated.' }
    #format.json { render :user/:username/edit, status: :created, location: @user }
    current_user.save
    redirect_to user_profile_path(current_user.username)
    # if( current_user.save())
    # return
    # else
    #
    # end
  end

  def show
    #@user = User.find(params[:id])
  end

  def following
  end

  def followers
  end

  def message_friend
    @user = User.where.not('id = ?', current_user.id).order('created_at DESC')
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
      format.html { redirect_to landing_page_index_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    if current_user.nil?
      return status :unauthorized
    end
    respond_to do |format|
      format.json do
        @vote = current_user.votes.where(vote_params).first
        if @vote
          @vote.destroy
        else
          @vote = current_user.votes.where(item_id: params[:item_id], item_type: params[:item_type]).first
          if @vote
            @vote.update(vote_params)
          else
            @vote = current_user.votes.new(vote_params)
          end
          @vote.save
        end
        source_item = @vote.item_type.constantize.find(@vote.item_id)
        render json: {
            html: render_to_string(partial: 'user/vote.html.erb', locals: { item: source_item})
        }
      end
    end
  end

  def search
    sql_query = <<-SQL
      username LIKE :query OR
      first_name LIKE :query OR
      last_name LIKE :query
    SQL
    @results = User.where(sql_query, {query: "%#{params[:query]}%"}).page(params[:page]).per(25)
    respond_to do |format|
      format.json do
        response_json = {
            page: @results.current_page,
            total_count: @results.total_count,
            total_pages: @results.total_pages,
            items: []
        }
        @results.each do |person|
          item_obj = person.slice(:id, :username, :first_name, :last_name)
          item_obj.merge!({
              profile_path:  Rails.application.routes.url_helpers.user_profile_path(person.username),
              avatar_thumb: person.avatar.url(:icon)
          })
          response_json[:items].push(item_obj)
        end
        render json: response_json
      end
    end
  end

private

def set_user
  @user = User.where(username: params[:username]).first
  if @user.nil?
    render :text => 'User not found', :status => '404'
  end
end

def vote_params
  params.require(:vote).permit(:item_id, :item_type, :value)
end

def user_params
  params.require(:user).permit(:id, :first_name, :last_name, :username, :email, :phone_number, :location, :about_me, :avatar)
end

end
