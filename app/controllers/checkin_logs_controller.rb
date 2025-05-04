class CheckinLogsController < ApplicationController
  include Pagy::Backend

  before_action :set_facility
  before_action :set_current_location
  def index
    @pagy, @checkin_logs = pagy(current_user.checkin_dates_for(@facility))
  end

  def create
    respond_to do |format|
      if @facility.within_distance?(@current_lat, @current_lng)
        checkin_within_range(format)
      else
        checkin_out_of_range(format)
      end
    end
  end

  private

  def set_facility
    @facility = Facility.find(params[:facility_id])
  end

  def set_current_location
    @current_lat = params[:latitude].to_f
    @current_lng = params[:longitude].to_f
  end

  def checkin_within_range(format)
    if current_user.checked_in_today_to?(@facility)
      format.turbo_stream { render_chechin_limit_modal }
    else
      render_checkin_modal_if_first_visit(format)
      current_user.check_in(@facility)
      format.html { redirect_to facility_checkin_logs_path(@facility) }
    end
  end

  def render_checkin_modal_if_first_visit(format)
    if current_user.first_visit_to?(@facility)
      format.turbo_stream { render_checkin_modal }
    end
  end

  def checkin_out_of_range(format)
    format.turbo_stream { render_checkin_out_of_range_modal }
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

  def render_checkin_out_of_range_modal
    render turbo_stream: turbo_stream.update(
      "checkin-out-of-range-modal-frame",
      partial: "facilities/checkin_out_of_range_modal",
    )
  end
end
