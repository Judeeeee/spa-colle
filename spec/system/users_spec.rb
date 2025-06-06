require 'rails_helper'

RSpec.describe "Users", type: :system do
  before(:each) do
    driven_by :selenium_chrome_headless
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  describe 'authenticating with google' do
    context "when credentials are valid" do
      let!(:user) { create(:user) }

      it "displays the top page after login" do
        login_with_google(user)
        expect(page).to have_selector('h1', text: 'スタンプカード')
      end
    end

    context "when credentials are invalid" do
      it "displays an authentication failure message" do
        login_with_google_failure(:invalid_credentials)
        expect(page).to have_content('Google認証に失敗しました。もう一度ログインしてください。')
      end
    end

    context "when authentication times out" do
      it "displays a timeout error message" do
        login_with_google_failure(:timeout)
        expect(page).to have_content('Google認証がタイムアウトしました。もう一度お試しください。')
      end
    end

    context "when access is denied by the user" do
      it "displays an access denied message" do
        login_with_google_failure(:access_denied)
        expect(page).to have_content('Google認証が拒否されました。')
      end
    end
  end

  describe 'log out' do
    context "when logs out the user" do
      let!(:user) { create(:user) }

      it "redirect before login page" do
        login_with_google(user)
        expect(page).to have_selector('h1', text: 'スタンプカード')
        click_link "ログアウト"

        expect(page).to have_button("Googleでログイン")
      end
    end
  end

  describe 'delete account' do
    context "when delete the account" do
      let!(:user) { create(:user) }

      it "redirect before login page" do
        login_with_google(user)
        expect(page).to have_selector('h1', text: 'スタンプカード')

        click_link "アカウント削除"
        expect(page).to have_selector('[data-controller="modal"]', visible: true, wait: 5)

        within('[data-controller="modal"]') do
          expect(page).to have_content("アカウント削除")
          click_button "削除する"
        end

        expect(page).to have_button("Googleでログイン")
      end
    end
  end

  describe 'create account' do
    context "when create the account" do
      let(:user) { build(:user) }

      it "redirect after login page" do
        expect(User.exists?(email: user.email)).to be false

        login_with_google(user)
        sleep 1 # ログイン処理が完了するのを待つ
        expect(User.exists?(email: user.email)).to be true

        expect(page).to have_selector('h1', text: 'スタンプカード')
      end
    end
  end
end
