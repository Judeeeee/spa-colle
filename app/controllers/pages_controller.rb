class PagesController < ApplicationController
  skip_before_action :check_logged_in,  only: [ :index, :terms, :privacy ]
  def index
    @wards = Ward.ordered_by_kana
    @facility_counts_by_wards = Facility.group(:ward_id).count
    @visited_facility_counts_by_wards = current_user.visited_facility_counts_by_ward if current_user
  end

  def terms
  end

  def privacy
  end
end
