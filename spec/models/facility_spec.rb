require 'rails_helper'

RSpec.describe Facility, type: :model do
  describe '#within_distance?' do
  let!(:not_check_in_facility) { create(:not_check_in_facility) }

    context 'when the location is within 200 meters' do
      it 'returns true' do
        # 約100m北東の地点
        expect(not_check_in_facility.within_distance?(35.698800, 139.768500)).to be true
      end
    end

    context 'when the location is more than 200 meters away' do
      it 'returns false' do
        # 約500m北西の地点
        expect(not_check_in_facility.within_distance?(35.6751907, 139.7542611)).to be false
      end
    end
  end
end
