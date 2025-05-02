require 'rails_helper'
# describe の引数にはテストの対象
# context の引数にはテストが実行される際に前提になる条件や状態(xxxの時、xxxの場合)
# itには期待する値
RSpec.describe SessionsHelper, type: :helper do
  let!(:user) { create(:user) }

  describe '#current_user' do
    context 'when session contains user_id' do
      it 'returns the logged in user' do
        helper.log_in(user)
        expect(helper.current_user).to eq(user)
      end
    end

    context 'when the user is not logged in' do
      it 'returns nil' do
        expect(helper.current_user).to be_nil
      end
    end
  end

  describe '#log_in' do
    context 'when logging in a user' do
      it 'stores user_id in session' do
        helper.log_in(user)
        expect(session[:user_id]).to eq(user.id)
      end
    end
  end

  describe '#log_out' do
    context 'when a user is logged in' do
      it 'clears the session and @current_user' do
        helper.log_in(user)
        expect(helper.current_user).to eq(user)

        helper.log_out
        expect(session[:user_id]).to be_nil
        expect(helper.current_user).to be_nil
      end
    end
  end
end
