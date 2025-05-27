class MapsController < ApplicationController
  def index
    @facilities = Facility.all
  end
end
