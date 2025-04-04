# https://github.com/teamcapybara/capybara?tab=readme-ov-file#configuring-and-adding-drivers
if Rails.env.test?
  Capybara.register_driver :selenium_chrome_without_cache do |app|
    options = Selenium::WebDriver::Chrome::Options.new

    # 位置情報確認ダイアログを表示させるために、テスト毎にキャッシュを無効化
    options.add_argument("--disable-application-cache")
    options.add_argument("--disable-cache")
    options.add_argument("--incognito")

    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  Capybara.javascript_driver = :selenium_chrome_without_cache
end
