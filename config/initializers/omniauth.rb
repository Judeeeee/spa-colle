# メールアドレスのみ要求する
# ユーザーに表示される説明文でユーザー名とプロフィールについて書いてあるのは変えられないっぽい？
# https://github.com/zquestz/omniauth-google-oauth2?tab=readme-ov-file#configuration

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Rails.application.credentials.google[:client_id],
           Rails.application.credentials.google[:client_secret],
           { scope: "email" }
end
