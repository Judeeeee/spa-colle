class FacilitiesController < ApplicationController
  def index
    facilities = Facility.joins(:ward).order("wards.name_kana")
    @grouped_facilities = facilities.group_by { |facility| facility.ward.name }
  end

  def show
  end

  def map
    @facilities = Facility.all
  end
end
