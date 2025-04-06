require 'rails_helper'

RSpec.describe "CheckinLogs", type: :system do
  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: { email: 'test@example.com', name: 'Test User', image: 'https://lh3.googleusercontent.com/a/ACg8ocJU5kFyhguKfUQHg_HNx0EWfhjlAq066jpPNweO2xtrsAu-lq' },
      credentials: { token: 'mock_token', refresh_token: 'mock_refresh_token' }
    )
    driven_by :selenium_chrome

    visit root_path
    click_button 'Googleでログイン'
    expect(page).to have_selector('h1', text: 'spa colle')
  end

  def fill_in_location_and_submit(lat:, lng:)
    page.execute_script("document.getElementById('latitude').value = #{lat};")
    page.execute_script("document.getElementById('longitude').value = #{lng};")

    click_button "チェックインする"
  end

  context "the current location is within 200 meters of the facility" do
    it "successfully checks in" do
      visit "/facilities/1" # { ward_id: 1, name: "RAKU SPA 1010 神田", latitude: 35.698137, longitude: 139.767935 }
      expect(page).to have_selector('h1', text: 'RAKU SPA 1010 神田')

      fill_in_location_and_submit(lat: 35.698800, lng: 139.768500) # 約100m北東

      within "#checkin-modal-frame" do
        expect(page).to have_content("初回チェックイン🎉")
        click_button "閉じる"
      end

      expect(page).to have_selector('h1', text: 'チェックインログ')
      expect(page).to have_content(Time.zone.today.strftime("%Y/%m/%d"))
    end

    it "fails to check in" do
      visit "/facilities/2" # { ward_id: 2, name: "SPA&SAUNA コリドーの湯", latitude: 35.6706907, longitude: 139.7599611 }
      expect(page).to have_selector('h1', text: 'SPA&SAUNA コリドーの湯')

      fill_in_location_and_submit(lat: 35.6751907, lng: 139.7542611) # 約500m北西

      within "#checkin-out-of-range-modal-frame" do
        expect(page).to have_content("チェックインに失敗しました😢")
      end
    end
  end
end
