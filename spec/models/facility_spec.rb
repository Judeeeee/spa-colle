require 'rails_helper'

RSpec.describe Facility, type: :model do
  describe '#within_distance?' do
  let!(:not_check_in_facility) { create(:not_check_in_facility) }

    it 'returns true if within 200m' do
      # 約100m北東の地点
      expect(not_check_in_facility.within_distance?(35.698800, 139.768500)).to be true
    end

    it 'returns false if outside 200m' do
      # 約500m北西の地点
      expect(not_check_in_facility.within_distance?(35.6751907, 139.7542611)).to be false
    end
  end
end
