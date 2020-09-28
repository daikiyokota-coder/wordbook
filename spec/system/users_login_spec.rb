require 'rails_helper'
RSpec.describe 'UsersLogin', type: :system do
  before do
    create(:user)
  end

  it 'ログイン画面でDBに登録された名前とパスワードを入力するとログイン状態になりroot_pathにリダイレクトされる' do
    visit login_path
    fill_in 'ユーザー名', with: 'testname1'
    fill_in 'パスワード', with: 'hogehoge'
    click_button 'ログイン'
    expect(page).to have_current_path "/"
  end
end
