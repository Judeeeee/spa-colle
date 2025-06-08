class MapsController < ApplicationController
  def index
    @facility_pins = Facility.select(:name, :latitude, :longitude)
  end
end
