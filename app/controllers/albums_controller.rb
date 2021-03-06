class AlbumsController < ApplicationController
  before_action :set_album, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :index, :edit, :new]

  # GET /albums
  # GET /albums.json
  def index
    # @albums = Album.all
    @albums = @user.albums
    unless params[:query].blank?
      @albums = @albums.where("title like ?", "%#{params[:query]}%")
    end
=begin
    unless params[:username].blank?
      @albums = @user.albums.where(title: params[:title]).first
    end
    @albums = @albums.order('created_at desc').page(params[:page]).per(10)
=end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = @user.albums.where(title: params[:title]).first
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to album_show_page_path(username: @album.user.username, title: @album.title), notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to album_show_page_path(username: @album.user.username, title: @album.title), notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.where(username: params[:username]).first
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:user_id, :title, :access)
    end
end
