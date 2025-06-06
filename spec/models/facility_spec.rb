require 'rails_helper'

RSpec.describe Facility, type: :model do
  describe '.with_ward_ordered_by_kana' do
    let!(:shinjuku_ward) { create(:shinjuku_ward) }
    let!(:taito_ward) { create(:taito_ward) }
    let!(:chiyoda_ward) { create(:chiyoda_ward) }

    let!(:facility_shinjuku) { create(:facility, ward: shinjuku_ward) }
    let!(:facility_taito)  { create(:facility, ward: taito_ward) }
    let!(:facility_chiyoda)  { create(:facility, ward: chiyoda_ward) }

    context 'when facilities belong to wards with different name_kana' do
      it 'returns facilities ordered by wards.name_kana asc' do
        result = Facility.with_ward_ordered_by_kana
        expect(result).to eq([ facility_shinjuku, facility_taito, facility_chiyoda ])
      end
    end
  end

  describe '#within_distance?' do
    let!(:ward) { create(:ward) }
    let!(:facility) {
      create(:facility,
              ward: ward,
              name: "チェックイン可能範囲テスト施設",
              latitude: 35.698137,
              longitude: 139.767935
            )
    }

    context 'when the location is within 200 meters' do
      it 'returns true' do
        # 約100m北東の地点
        expect(facility.within_distance?(35.698800, 139.768500)).to be true
      end
    end

    context 'when the location is more than 200 meters away' do
      it 'returns false' do
        # 約500m北西の地点
        expect(facility.within_distance?(35.6751907, 139.7542611)).to be false
      end
    end
  end
end
