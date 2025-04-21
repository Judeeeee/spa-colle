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
    driven_by :selenium_chrome_headless

    visit root_path
    click_button 'Googleでログイン'
    expect(page).to have_selector('h1', text: 'スパコレ')
  end

  def fill_in_location_and_submit(lat:, lng:)
    page.execute_script("document.getElementById('latitude').value = #{lat};")
    page.execute_script("document.getElementById('longitude').value = #{lng};")

    click_button "チェックイン"
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

  context "when there are no check-in logs" do
    it "displays a message indicating that there are no check in logs yet" do
      visit "/facilities/3"
      expect(page).to have_selector('h1', text: 'テルマー湯 西麻布')
      expect(page).to have_content("0回訪問")

      click_link "チェックインログページへ"

      expect(page).to have_selector('h1', text: 'チェックインログ')
      expect(page).to have_content("チェックインログはまだありません♨️")
      expect(page).to have_content("施設を訪問してチェックインしましょう！")
    end
  end

  context "when there are 11 more check-in logs" do
    it "displays pagination" do
      user = User.find_by(email: 'test@example.com')
      11.times do |i|
        created_at = Time.zone.today - i.days
        CheckinLog.create!(user_id: user.id, facility_id: 4, created_at:)
      end

      visit "/facilities/4"
      expect(page).to have_selector('h1', text: 'テルマー湯 新宿店')
      expect(page).to have_content("11回訪問")

      click_link "チェックインログページへ"

      expect(page).to have_selector('h1', text: 'チェックインログ')
      expect(page).to have_selector('nav.pagy.nav')
    end
  end
end
