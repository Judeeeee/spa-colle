class User < ApplicationRecord
  has_many :checkin_logs, dependent: :delete_all

  validates :email, uniqueness: true

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_create_by(email: user_params[:email]) do |user|
        user.update(user_params)
      end
    end

    private

    def user_params_from_auth_hash(auth_hash)
      {
        email: auth_hash.info.email
      }
    end
  end

  def check_in(facility)
    CheckinLog.create!(user: self, facility: facility)
  end

  def checkin_dates_for(facility)
    checkin_logs.where(facility: facility).order(created_at: :asc)
  end

  def visited?(facility)
    checkin_logs.for_facility(facility).exists?
  end

  def checked_in_today_to?(facility)
    checkin_logs.for_facility(facility).today.exists?
  end
end
