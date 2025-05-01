require 'rails_helper'

RSpec.describe 'Geolocation Error Handling', type: :system, js: true do
  let(:user) { create(:user) }
  let!(:not_check_in_facility) { create(:not_check_in_facility) }

  before(:each) do
    driven_by :selenium_chrome_without_cache
    login_with_google(user)
    expect(page).to have_selector('h1', text: 'スパコレ')
  end

  def mock_geolocation_success
    page.execute_script(<<~JS)
      navigator.geolocation.getCurrentPosition = function(success, error) {
        success({ coords: { latitude: 35.698137, longitude: 139.767935 } });
      };
    JS
  end

  def mock_geolocation_error
    page.execute_script(<<~JS)
      navigator.geolocation.getCurrentPosition = function(success, error) {
        error({ code: 1, message: "User denied Geolocation" });
      };
    JS
  end

  it 'displays the map with the current location when location permission is granted' do
    visit facilities_map_path
    mock_geolocation_success

    expect(page).to have_selector('h1', text: '付近の施設を検索', wait: 5)
    expect(page).to have_selector('#map', visible: true)
  end

  it 'displays an alert when location permission is denied' do
    visit facilities_map_path
    mock_geolocation_error

    expect(page).to have_selector('h1', text: '付近の施設を検索', wait: 5)
    accept_alert '位置情報の使用が許可されなかったため、現在地を取得できませんでした。'
  end

  it 'displays the map on the facility page when location permission is granted' do
    visit facility_path(not_check_in_facility)
    mock_geolocation_success

    expect(page).to have_selector('h1', text: '未チェックイン施設', wait: 5)
    expect(page).to have_selector('#facility-map', visible: true)
  end

  it 'displays an alert on the facility page when location permission is denied' do
    visit facility_path(not_check_in_facility)
    mock_geolocation_error

    accept_alert '位置情報の使用が許可されなかったため、現在地を取得できませんでした。'
    expect(page).to have_selector('h1', text: '未チェックイン施設', wait: 5)
  end
end
