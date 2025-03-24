class PagesController < ApplicationController
  skip_before_action :check_logged_in,  only: [ :index, :terms ]
  def index
    @wards = Ward.joins(:facilities).distinct.order("name_kana")
  end

  def terms
  end
end
