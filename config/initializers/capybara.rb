# https://github.com/teamcapybara/capybara?tab=readme-ov-file#configuring-and-adding-drivers
if Rails.env.test?
  require "securerandom"
  require "tmpdir"

  Capybara.register_driver :selenium_chrome_without_cache do |app|
    options = Selenium::WebDriver::Chrome::Options.new

    Capybara.save_path = "/tmp/capybara"
    Capybara.server_host = "0.0.0.0"
    Capybara.always_include_port = true

    # 位置情報確認ダイアログを表示させるために、テスト毎にキャッシュを無効化
    options.add_argument("--headless=new")
    options.add_argument("--disable-application-cache")
    options.add_argument("--disable-cache")
    options.add_argument("--incognito")

    # tmpディレクトリを安全にユニークに確保
    user_data_dir = Dir.mktmpdir("chrome-user-data")
    options.add_argument("--user-data-dir=#{user_data_dir}")

    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  Capybara.javascript_driver = :selenium_chrome_without_cache
end
