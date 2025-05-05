class FacilitiesController < ApplicationController
  before_action :set_facility, only: %w[show]

  def index
    @grouped_facilities = Facility.grouped_by_ward_name
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
