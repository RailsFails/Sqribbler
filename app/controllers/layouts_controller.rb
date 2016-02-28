class LayoutsController < ApplicationController

  def contact_page

  end

  def canvas
    @image = nil
    unless params[:image_id].blank?
      @image = Image.find(params[:image_id])
    end
    render :layout => "canvas"
  end

end