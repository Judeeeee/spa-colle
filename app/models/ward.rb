class Ward < ApplicationRecord
  has_many :facilities

  def visited_by_user?(user)
    facilities.joins(:checkin_logs).where(checkin_logs: { user_id: user.id }).exists?
  end
end
