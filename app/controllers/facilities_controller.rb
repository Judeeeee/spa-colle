class FacilitiesController < ApplicationController
  def index
  end

  def show
  end

  def map
    @facilities = Facility.all
  end
end
