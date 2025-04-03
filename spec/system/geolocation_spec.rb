require 'rails_helper'

RSpec.describe 'Geolocation Error Handling', type: :system, js: true do
  before do
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
  end

  it 'displays an alert when location permission is denied' do
    click_link '付近の施設を検索'
    expect(page).to have_selector('h1', text: '付近の施設を検索')

    page.evaluate_script(<<-JS)
      navigator.geolocation.getCurrentPosition = function(success, error) {
        error({ code: 1 });
      };
      initMapWithCurrentLocation();
    JS

    accept_alert '位置情報の使用が許可されなかっため、現在地を取得できませんでした。'
  end
end
