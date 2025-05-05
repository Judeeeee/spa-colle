require 'rails_helper'

RSpec.describe Ward, type: :model do
  describe '.visited_ids_by' do
    let!(:user) { create(:user) }

    context 'when the user has checked in to facilities in multiple wards' do
      let(:chiyoda_ward) { create(:chiyoda_ward) }
      let(:chuo_ward) { create(:chuo_ward) }
      let(:chiyoda_facility) { create(:facility, ward: chiyoda_ward) }
      let(:chuo_facility) { create(:facility, ward: chuo_ward) }

      before do
        create(:checkin_log, user: user, facility: chiyoda_facility)
        create(:checkin_log, user: user, facility: chuo_facility)
      end

      it 'returns only the IDs of the visited wards' do
        result = Ward.visited_ids_by(user)
        expect(result).to match_array([ chiyoda_ward.id, chuo_ward.id ])
      end
    end

    context 'when the user has not checked in to any facilities' do
      it 'returns an empty array' do
        expect(Ward.visited_ids_by(user)).to eq([])
      end
    end
  end
end
