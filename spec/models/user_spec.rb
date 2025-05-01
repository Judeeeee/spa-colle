require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_or_create_from_auth_hash' do
    let(:auth_hash) do
      # https://github.com/zquestz/omniauth-google-oauth2?tab=readme-ov-file#auth-hash
      OmniAuth::AuthHash.new({
        info: {
          name: 'Test User',
          email: 'test@example.com',
          image: 'http://image.url'
        }
      })
    end

    it 'creates a new user if not exists' do
      expect {
        User.find_or_create_from_auth_hash(auth_hash)
      }.to change { User.count }.by(1)
    end

    it 'does not create a user if one already exists' do
      User.create!(name: 'Test User', email: 'test@example.com', image: 'http://image.url')

      expect {
        User.find_or_create_from_auth_hash(auth_hash)
      }.not_to change { User.count }
    end
  end

  describe '#check_in' do
    let(:user) { create(:user) }
    let(:not_check_in_facility) { create(:not_check_in_facility) }

    it 'creates a CheckinLog for the facility' do
      expect {
        user.check_in(not_check_in_facility)
      }.to change { CheckinLog.count }.by(1)
    end
  end

  describe '#checkin_dates_for' do
    let(:user) { create(:user) }
    let(:many_check_in_facility) { create(:many_check_in_facility) }
    let!(:checkin_logs) do
      10.times.map { |i| create(:checkin_log, user: user, facility: many_check_in_facility, days_ago: i) }
    end

    it 'returns asc created_at ordered check-in logs' do
      check_in_logs = user.checkin_dates_for(many_check_in_facility).pluck(:created_at)
      expect(check_in_logs).to eq(check_in_logs.sort)
    end
  end
end
