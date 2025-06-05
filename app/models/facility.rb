class Facility < ApplicationRecord
  THRESHOLD_KM = 0.2
  EARTH_RADIUS_KM = 6371.0

  belongs_to :ward
  has_many :checkin_logs, dependent: :destroy

  scope :with_ward_ordered_by_kana, -> { includes(:ward).joins(:ward).order("wards.name_kana") }

  def self.grouped_by_ward_name
    with_ward_ordered_by_kana.group_by { |facility| facility.ward.name }
  end

  def within_distance?(current_lat, current_lng)
    # 距離計算（Haversine公式）
    distance = distance_by_pythagoras(self, current_lat, current_lng)
    distance <= THRESHOLD_KM
  end

  private

  # 二点間の距離を計算(Haversine公式)
  def distance_by_pythagoras(facility, current_lat, current_lng)
    # 緯度・経度をラジアンに変換
    rad_facility_lat = facility.latitude * Math::PI / 180.0
    rad_facility_lng = facility.longitude * Math::PI / 180.0
    rad_current_lat = current_lat * Math::PI / 180.0
    rad_current_lng = current_lng * Math::PI / 180.0
    delta_lat = rad_current_lat - rad_facility_lat
    delta_lon = rad_current_lng - rad_facility_lng
    delta_x = delta_lon * Math.cos((rad_facility_lat + rad_current_lat) / 2.0) # 経度方向を緯度で調整
    delta_y = delta_lat

    Math.sqrt(delta_x**2 + delta_y**2) * EARTH_RADIUS_KM
  end
end
