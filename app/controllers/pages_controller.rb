class PagesController < ApplicationController
  skip_before_action :check_logged_in,  only: [ :index, :terms, :privacy ]
  def index
    if current_user
      wards = Ward.ordered_by_kana
      @ward_visit_stats = visit_stats_by_ward(wards)
    end
  end

  def terms
  end

  def privacy
  end

  private

  def visit_stats_by_ward(wards)
    # [{"足立区" => {訪問数: 1, 全施設数: 2}...]を作成して、クエリ数を減らす
    wards.each_with_object({}) do |ward, stats|
      visited_count = current_user.checkin_logs.counts_visited_facility_in_ward(ward)
      stats[ward.name] = { visit_count: visited_count, total_facilities: ward.facilities.count }
    end
  end
end
