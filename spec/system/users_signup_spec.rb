require 'rails_helper'
RSpec.describe 'UsersSignup', type: :system do
  before do
    visit new_user_path
  end

  it 'ユーザー名、パスワード、パスワード(確認)を入力して作成ボタンを押すと、ユーザーが1人作成される' do
    expect do
      fill_in 'ユーザー名', with: 'testname1'
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認）', with: 'hogehoge'
      click_button '作成'
    end.to change(User, :count).by(1)
  end

  it '新規登録に成功すると、ログイン状態になってroot_pathにリダイレクトされる' do
    fill_in 'ユーザー名', with: 'testname1'
    fill_in 'パスワード', with: 'hogehoge'
    fill_in 'パスワード（確認）', with: 'hogehoge'
    click_button '作成'
    expect(page).to have_current_path '/'
    expect(page).to have_content 'ログアウト'
  end

  it 'ユーザー名を空欄で作成ボタンを押すと、ユーザーは作成されず、「名前を入力してください」と表示される' do
    expect do
      fill_in 'ユーザー名', with: ''
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認）', with: 'hogehoge'
      click_button '作成'
    end.to change(User, :count).by(0)
    expect(page).to have_content '名前を入力してください'
  end

  it 'パスワードを空欄で作成ボタンを押すと、ユーザーは作成されず、「パスワードを入力してください」と表示される' do
    expect do
      fill_in 'ユーザー名', with: 'testname1'
      fill_in 'パスワード', with: ''
      fill_in 'パスワード（確認）', with: 'hogehoge'
      click_button '作成'
    end.to change(User, :count).by(0)
    expect(page).to have_content 'パスワードを入力してください'
  end

  it '確認用パスワードを空欄で作成ボタンを押すと、ユーザーは作成されず、「確認用パスワードとパスワードの入力が一致しません」と表示される' do
    expect do
      fill_in 'ユーザー名', with: 'testname1'
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認）', with: ''
      click_button '作成'
    end.to change(User, :count).by(0)
    expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
  end

  it '既に存在する名前を入力して作成ボタンを押すと、ユーザーは作成されず、「名前はすでに存在します」と表示される' do
    create(:user, name: 'hogehoge')
    expect do
      fill_in 'ユーザー名', with: 'hogehoge'
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認）', with: 'hogehoge'
      click_button '作成'
    end.to change(User, :count).by(0)
    expect(page).to have_content '名前はすでに存在します'
  end
end
