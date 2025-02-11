class CheckinLogsController < ApplicationController
  before_action :set_facility
  def index
    @checkin_logs = current_user.checkin_dates_for(@facility)
  end

  def create
    @checkin_log = current_user.check_in(@facility)

    if @checkin_log.save
      redirect_to facility_checkin_logs_path(@facility)
    else
      # "チェックイン失敗時処理"
    end
  end

  private

  def set_facility
    @facility = Facility.find(params[:facility_id])
  end
end
