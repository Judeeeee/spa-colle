class CheckinLog < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  scope :for_facility, ->(facility) { where(facility_id: facility.id) }
  scope :today, -> { where(created_at: Time.zone.now.all_day) }
  scope :distinct_facility_counts_grouped_by_ward, -> {
    joins(:facility)
      .group("facilities.ward_id")
      .distinct
      .count("facility_id")
  }
end
