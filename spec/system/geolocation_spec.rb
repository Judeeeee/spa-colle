require 'rails_helper'

RSpec.describe 'Geolocation Error Handling', type: :system, js: true do
  let(:user) { create(:user) }
  let!(:not_check_in_facility) { create(:not_check_in_facility) }
  let(:selenium_driver) { Capybara.current_session.driver.browser } # SeleniumのWebDriverインスタンスを取得

  before(:each) do
    driven_by :selenium_chrome_without_cache # 位置情報確認ダイアログを表示させるために、テスト毎にキャッシュを無効化
    login_with_google(user)
    expect(page).to have_selector('h1', text: 'スパコレ')
    allow(selenium_driver).to receive(:execute_script).and_call_original
  end

  after(:each) do
    Capybara.reset_sessions!
  end

  def mock_geolocation_success
    allow(selenium_driver).to receive(:execute_script).and_wrap_original do |original, script, *args|
      if script.include?('navigator.geolocation.getCurrentPosition')
        original.call(<<~JS, *args)
          navigator.geolocation.getCurrentPosition = function(success, error) {
            success({ coords: { latitude: 35.698137, longitude: 139.767935 } });  // not_check_in_facilityの座標
          };
        JS
      else
        original.call(script, *args)# 地図描画のJSが壊れてしまうので
      end
    end
  end

  def mock_geolocation_error
    allow(selenium_driver).to receive(:execute_script).and_wrap_original do |original, script, *args|
      if script.include?('navigator.geolocation.getCurrentPosition')
        original.call(<<~JS, *args)
          navigator.geolocation.getCurrentPosition = function(success, error) {
            error({ code: 1 });
          };
        JS
      else
        original.call(script, *args)# 地図描画のJSが壊れてしまうので
      end
    end
  end

  it 'displays the map with the current location when location permission is granted' do
    visit facilities_map_path

    mock_geolocation_success
    expect(page).to have_selector('h1', text: '付近の施設を検索', wait: 5)  # Turboのロードが完全に終わるのを待つ

    expect(page).to have_selector('#map', visible: true)
  end

  it 'displays an alert when location permission is denied' do
    mock_geolocation_error

    visit facilities_map_path
    expect(page).to have_selector('h1', text: '付近の施設を検索', wait: 5) # Turboのロードが完全に終わるのを待つ"

    accept_alert '位置情報の使用が許可されなかったため、現在地を取得できませんでした。'
  end

  it 'displays the map on the facility page when location permission is granted' do
    visit facility_path(not_check_in_facility)

    mock_geolocation_success
    expect(page).to have_selector('h1', text: '未チェックイン施設', wait: 5)

    expect(page).to have_selector('#facility-map', visible: true)
  end

  it 'displays an alert on the facility page when location permission is denied on' do
    mock_geolocation_error

    visit facility_path(not_check_in_facility)

    accept_alert '位置情報の使用が許可されなかったため、現在地を取得できませんでした。'
    expect(page).to have_selector('h1', text: '未チェックイン施設', wait: 5) # Turboのロードが完全に終わるのを待つ"
  end
end
