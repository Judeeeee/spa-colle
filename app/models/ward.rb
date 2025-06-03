class Ward < ApplicationRecord
  has_many :facilities

  scope :ordered_by_kana, -> { order(:name_kana) }
end
