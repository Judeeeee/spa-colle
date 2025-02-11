class User < ApplicationRecord
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
        email: auth_hash.info.email
      }
    end
  end

  def check_in(facility)
    # TODO: 位置情報の判断ロジックは後で対応
    CheckinLog.new(user_id: self.id, facility_id: facility.id)
  end
end
