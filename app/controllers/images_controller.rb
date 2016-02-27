class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy, :add_album_title]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
    unless params[:username].blank?
      @images = User.where(username: params[:username]).first.images
    end
    if params[:format] == 'geojson'
      @images = @images.where('longitude is not NULL and latitude is not NULL')
    end
    @images = @images.order('created_at desc').page(params[:page]).per(25)
    respond_to do |format|
      format.html
      format.geojson
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @comment = Comment.new
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  def add_album_title

    @image.add_to_album(params[:album_title])
    @image.save
    head :ok
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.add_album_titles(params[:album_titles])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    @image.add_album_titles(params[:album_titles])
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:user_id, :title, :description, :attachment, :album_titles, :latitude, :longitude)
    end
end
