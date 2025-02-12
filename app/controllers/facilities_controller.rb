class FacilitiesController < ApplicationController
  before_action :set_facility, only: %w[show]

  def index
    facilities = Facility.joins(:ward).order("wards.name_kana")
    @grouped_facilities = facilities.group_by { |facility| facility.ward.name }
  end

  def show
    @checkin_count = @facility.checkin_logs.size
  end

  def map
    @facilities = Facility.all
  end

  private

  def set_facility
    @facility = Facility.find(params[:id])
  end
end
