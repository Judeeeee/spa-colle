require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }

  describe '#current_user' do
    it 'returns the logged in user when session contains user_id' do
      helper.log_in(user)
      expect(helper.current_user).to eq(user)
    end

    it 'returns nil when no user is logged in' do
      expect(helper.current_user).to be_nil
    end
  end

  describe '#log_in' do
    it 'stores user_id in session' do
      helper.log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe '#log_out' do
    it 'clears the session and @current_user' do
      helper.log_in(user)
      expect(helper.current_user).to eq(user)

      helper.log_out
      expect(session[:user_id]).to be_nil
      expect(helper.current_user).to be_nil
    end
  end
end
