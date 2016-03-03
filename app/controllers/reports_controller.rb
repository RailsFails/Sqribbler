class ReportsController < ApplicationController
  def index
    @reports = Report.all.page(params[:page]).per(50)
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.ip_address = request.remote_ip
    @report.user_id = current_user.id unless current_user.nil?
    @report.save
    redirect_to :back
  end

  private
  def report_params
    params.require(:report).permit(:item_id, :item_type, :user_id, :ip_address, :reason, :comment, :image_id, :comment_id)
  end
end