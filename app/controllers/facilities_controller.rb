class FacilitiesController < ApplicationController
  before_action :set_facility, only: %w[show]

  def index
    @wards = Ward.includes(:facilities).ordered_by_kana
    @visited_facility_ids = current_user.checkin_logs.pluck(:facility_id)
  end

  def show
    @checkin_count = current_user.checkin_dates_for(@facility).size
  end

  private

  def set_facility
    @facility = Facility.find(params[:id])
  end
end
