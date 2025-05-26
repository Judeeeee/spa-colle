class Ward < ApplicationRecord
  has_many :facilities

  scope :ordered_by_kana, -> { order(:name_kana) }

  scope :visited_by, ->(user) {
    joins(facilities: :checkin_logs)
      .where(checkin_logs: { user_id: user.id })
  }
end
