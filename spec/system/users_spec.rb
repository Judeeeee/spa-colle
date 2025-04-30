require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  before(:each) do
    driven_by :selenium_chrome_headless
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  # TODO: ブランチ名を変更
  context "Successfully authenticates with Google account" do
    it "displays the top page after login" do
      login_with_google(user)
      expect(page).to have_selector('h1', text: 'スパコレ')
    end
  end

  context "Fails due to invalid credentials" do
    it "displays an authentication failure message" do
      login_with_google_failure(:invalid_credentials)
      expect(page).to have_content('Google認証に失敗しました。もう一度ログインしてください。')
    end
  end

  context "Fails due to timeout" do
    it "displays a timeout error message" do
      login_with_google_failure(:timeout)
      expect(page).to have_content('Google認証がタイムアウトしました。もう一度お試しください。')
    end
  end

  context "Fails due to access denial" do
    it "displays an access denied message" do
      login_with_google_failure(:access_denied)
      expect(page).to have_content('Google認証が拒否されました。')
    end
  end
end
