
module GoogleOauth
  def mock_google_oauth(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        email: user.email
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token'
      }
    )
  end

  def mock_google_oauth_failure(error_type)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = error_type
  end

  def login_with_google(user)
    mock_google_oauth(user)
    visit root_path
    click_button 'Googleでログイン'
  end

  def login_with_google_failure(error_type)
    mock_google_oauth_failure(error_type)
    visit root_path
    click_button 'Googleでログイン'
  end
end
