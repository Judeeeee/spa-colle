class Ward < ApplicationRecord
  has_many :facilities

  scope :with_facilities_ordered, -> {
    joins(:facilities).includes(:facilities).distinct.order(:name_kana)
  }

  scope :visited_by, ->(user) {
    joins(facilities: :checkin_logs)
      .where(checkin_logs: { user_id: user.id })
  }

  def self.visited_ids_by(user)
    visited_by(user).pluck(:id)
  end
end
