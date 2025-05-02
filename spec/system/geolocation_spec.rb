require 'rails_helper'

RSpec.describe 'Geolocation Error Handling', type: :system, js: true do
  let(:user) { create(:user) }
  let!(:not_check_in_facility) { create(:not_check_in_facility) }

  def mock_geolocation_success
    page.execute_script(<<~JS)
      Object.defineProperty(navigator, "geolocation", {
        value: {
          getCurrentPosition: function(success, error) {
            success({ coords: { latitude: 35.698137, longitude: 139.767935 } });
          }
        }
      });
    JS
  end

  def mock_geolocation_error
    page.execute_script(<<~JS)
      Object.defineProperty(navigator, "geolocation", {
        value: {
          getCurrentPosition: function(success, error) {
            error({ code: 1, message: "User denied Geolocation" });
          }
        }
      });
    JS
  end

  before do
    driven_by :selenium_chrome_without_cache
    visit root_path
    login_with_google(user)
    expect(page).to have_selector('h1', text: 'スパコレ', wait: 5)
  end

  context 'when location permission is granted' do
    it 'displays the map with the current location on the map page' do
      mock_geolocation_success
      sleep 2 # モックの反映を保証する
      click_link "付近の施設を検索"

      expect(page).to have_selector('#map', visible: true, wait: 5)
      expect(page).to have_selector('h1', text: '付近の施設を検索', wait: 5)
    end

    it 'displays the map on the facility page' do
      mock_geolocation_success
      sleep 2 # モックの反映を保証する
      click_link "施設一覧"

      find('summary', text: '千代田区').click
      find('.facility-link', text: '未チェックイン施設').click

      expect(page).to have_selector('#facility-map', visible: true, wait: 5)
      expect(page).to have_selector('h1', text: '未チェックイン施設', wait: 5)
    end
  end

  context 'when location permission is denied' do
    it 'displays an alert on the map page' do
      mock_geolocation_error
      sleep 2 # モックの反映を保証する
      click_link "付近の施設を検索"

      accept_alert('位置情報の使用が許可されなかったため、現在地を取得できませんでした。', wait: 5)
      expect(page).to have_selector('#map', visible: true, wait: 5)
      expect(page).to have_selector('h1', text: '付近の施設を検索', wait: 5)
    end

    it 'displays an alert on the facility page' do
      mock_geolocation_error
      sleep 2 # モックの反映を保証する
      click_link "施設一覧"

      find('summary', text: '千代田区').click
      find('.facility-link', text: '未チェックイン施設').click

      accept_alert('位置情報の使用が許可されなかったため、現在地を取得できませんでした。', wait: 5)
      expect(page).to have_selector('#facility-map', visible: true, wait: 5)
      expect(page).to have_selector('h1', text: '未チェックイン施設', wait: 5)
    end
  end
end
