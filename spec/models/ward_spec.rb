require 'rails_helper'

RSpec.describe Ward, type: :model do
  describe '#visited_by_user?' do
    let!(:user) { create(:user) }
    let!(:ward) { create(:bunkyo_ward) }
    let!(:facility) { create(:checked_in_facility, ward: ward) }

    context 'when user has checked in to a facility in the ward' do
      let!(:checkin_log) { create(:checkin_log, user: user, facility: facility) }

      it 'returns true' do
        expect(ward.visited_by_user?(user)).to be true
      end
    end

    context 'when user has not checked in to any facility in the ward' do
      it 'returns false' do
        expect(ward.visited_by_user?(user)).to be false
      end
    end
  end
end
