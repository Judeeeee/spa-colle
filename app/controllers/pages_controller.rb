class PagesController < ApplicationController
  skip_before_action :check_logged_in,  only: [ :index, :terms ]
  def index
    @wards = Ward.with_facilities_ordered
    @visited_ward_ids = Ward.visited_ids_by(current_user) if current_user
  end

  def terms
  end
end
