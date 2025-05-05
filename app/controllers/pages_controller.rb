class PagesController < ApplicationController
  skip_before_action :check_logged_in,  only: [ :index, :terms ]
  def index
    @wards = Ward.with_facilities_ordered
  end

  def terms
  end
end
