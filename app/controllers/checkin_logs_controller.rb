class CheckinLogsController < ApplicationController
  before_action :set_facility
  before_action :set_current_location
  def index
    @checkin_logs = current_user.checkin_dates_for(@facility)
  end

  def create
    if @facility.within_distance?(@current_lat, @current_lng)

      respond_to do |format|
        if already_checked_in_today?
          format.turbo_stream { render_chechin_limit_modal }
        else
          format.turbo_stream { render_checkin_modal } if first_visit?
          current_user.check_in(@facility)
          format.html { redirect_to facility_checkin_logs_path(@facility) }
        end
      end
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

  def first_visit?
    !current_user.checkin_logs.exists?(facility_id: @facility.id)
  end

  def already_checked_in_today?
    current_user.checkin_logs.exists?(facility_id: @facility.id, created_at: Time.zone.now.all_day)
  end

  def render_checkin_modal
    render turbo_stream: turbo_stream.update(
      "checkin-modal-frame",
      partial: "facilities/checkin_modal",
      locals: { facility: @facility }
    )
  end

  def render_chechin_limit_modal
    render turbo_stream: turbo_stream.update(
      "checkin-limit-modal-frame",
      partial: "facilities/checkin_limit_modal",
    )
  end
end
