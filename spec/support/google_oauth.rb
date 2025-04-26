
module GoogleOauth
  def mock_google_oauth(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        email: user.email,
        name: user.name,
        image: 'https://lh3.googleusercontent.com/a/default_image_url'
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token'
      }
    )
  end

  def login_with_google(user)
    mock_google_oauth(user)
    visit root_path
    click_button 'Googleでログイン'
  end
end
