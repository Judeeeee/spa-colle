require 'rails_helper'

RSpec.describe 'Geolocation Error Handling', type: :system, js: true do
  let!(:user) { create(:user) }

  before do
    create(:facility, name: "未チェックイン施設", latitude: 35.698137, longitude: 139.767935)
  end

  before do
    driven_by :selenium_chrome_headless
    visit root_path
    login_with_google(user)
  end

  describe 'location permission' do
    context 'when permission is granted' do
      it 'displays the map with the current location on the map page' do
        expect(page).to have_selector('h1', text: 'スタンプカード')

        mock_geolocation_success(35.698137, 139.767935)
        sleep 2 # モックの反映を保証する
        click_link "地図からチェックイン"

        expect(page).to have_selector('#map', visible: true, wait: 5)
        expect(page).to have_selector('h1', text: 'スーパー銭湯マップ', wait: 5)
      end

      it 'displays the map on the facility page' do
        expect(page).to have_selector('h1', text: 'スタンプカード')

        mock_geolocation_success(35.698137, 139.767935)
        sleep 2 # モックの反映を保証する
        click_link "施設一覧"

        find('.facility-link', text: '未チェックイン施設').click

        expect(page).to have_selector('#facility-map', visible: true, wait: 5)
        expect(page).to have_selector('h1', text: '未チェックイン施設', wait: 5)
      end
    end

    context 'when permission is denied' do
      it 'displays an alert on the map page' do
        expect(page).to have_selector('h1', text: 'スタンプカード')

        mock_geolocation_error
        sleep 2 # モックの反映を保証する
        click_link "地図からチェックイン"

        accept_alert('位置情報の使用が許可されなかったため、現在地を取得できませんでした。', wait: 5)
        expect(page).to have_selector('#map', visible: true, wait: 5)
        expect(page).to have_selector('h1', text: 'スーパー銭湯マップ', wait: 5)
      end

      it 'displays an alert on the facility page' do
        expect(page).to have_selector('h1', text: 'スタンプカード')

        mock_geolocation_error
        sleep 2 # モックの反映を保証する
        click_link "施設一覧"

        find('.facility-link', text: '未チェックイン施設').click

        accept_alert('位置情報の使用が許可されなかったため、現在地を取得できませんでした。', wait: 5)
        expect(page).to have_selector('#facility-map', visible: true, wait: 5)
        expect(page).to have_selector('h1', text: '未チェックイン施設', wait: 5)
      end
    end
  end
end
