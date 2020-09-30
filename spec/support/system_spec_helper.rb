module SystemSpecHelpers
  def make_user_and_login
    create(:user, name: 'testname')
    visit login_path
    fill_in 'ユーザー名', with: 'testname'
    fill_in 'パスワード', with: 'hogehoge'
    click_button 'ログイン'
  end
end
