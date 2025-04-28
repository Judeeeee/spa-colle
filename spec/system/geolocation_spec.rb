require 'rails_helper'

RSpec.describe 'Geolocation Error Handling', type: :system, js: true do
  let(:user) { create(:user) }

  before(:each) do
    driven_by :selenium_chrome_without_cache # 位置情報確認ダイアログを表示させるために、テスト毎にキャッシュを無効化
    login_with_google(user)
  end

  def mock_geolocation_error
    allow_any_instance_of(Selenium::WebDriver::Driver).to receive(:execute_script).and_wrap_original do |original, script, *args|
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

  it 'displays an alert when location permission is denied' do
    mock_geolocation_error

    click_link '付近の施設を検索'
    expect(page).to have_selector('h1', text: '付近の施設を検索', wait: 5) # Turboのロードが完全に終わるのを待つ"

    accept_alert '位置情報の使用が許可されなかったため、現在地を取得できませんでした。'
  end

  # TODO: 非同期処理の関係でアラートが表示されない
  # it 'displays an alert on the facility page when location permission is denied on' do
  #   visit "/facilities/1"
  #   expect(page).to have_selector('h1', text: 'RAKU SPA 1010 神田')

  #   page.evaluate_script(<<-JS)
  #     navigator.geolocation.getCurrentPosition = function(success, error) {
  #       error({ code: 1 });
  #     };
  #     initPage();
  #   JS

  #   accept_alert '位置情報の使用が許可されなかっため、現在地を取得できませんでした。'
  # end
end
