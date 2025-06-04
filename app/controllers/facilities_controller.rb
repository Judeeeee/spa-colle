class FacilitiesController < ApplicationController
  before_action :set_facility, only: %w[show]

  def index
    @grouped_facilities = groupe_facilities
    @visited_facility_ids = current_user.checkin_logs.pluck(:facility_id)
  end

  def show
    @checkin_count = current_user.checkin_dates_for(@facility).size
  end

  private

  def set_facility
    @facility = Facility.find(params[:id])
  end

  def groupe_facilities
    wards = Ward.ordered_by_kana
    wards.each_with_object({}) do |ward, hash|
      hash[ward.name] = ward.facilities
    end
  end
end
