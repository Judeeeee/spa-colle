class User < ApplicationRecord
  has_many :checkin_logs
  has_many :facilities, through: :checkin_logs

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
        name: auth_hash.info.name,
        email: auth_hash.info.email,
        image: auth_hash.info.image
      }
    end
  end

  def check_in(facility)
    CheckinLog.create!(user_id: self.id, facility_id: facility.id)
  end

  def checkin_dates_for(facility)
    checkin_logs.where(facility_id: facility.id).order(created_at: :asc)
  end

  def first_visit_to?(facility)
    checkin_logs.for_facility(facility).none?
  end

  def checked_in_today_to?(facility)
    checkin_logs.for_facility(facility).today.exists?
  end
end
