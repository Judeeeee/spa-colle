class CheckinLogsController < ApplicationController
  before_action :set_facility
  before_action :set_current_location
  def index
    @checkin_logs = current_user.checkin_dates_for(@facility)
  end

  def create
    if @facility.within_distance?(@current_lat, @current_lng)
      current_user.check_in(@facility)
      redirect_to facility_checkin_logs_path(@facility)
    else
      # "チェックイン失敗時処理"
    end
  end

  private

  def set_facility
    @facility = Facility.find(params[:facility_id])
  end

  def set_current_location
    @current_lat = params[:latitude].to_i
    @current_lng = params[:longitude].to_i
  end
end
