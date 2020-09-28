require 'rails_helper'
RSpec.describe 'UsersLogin', type: :system do
  before do
    create(:user)
    visit login_path
  end

  it 'ログイン画面でDBに登録されたユーザー名とパスワードを入力するとログイン状態になりroot_pathにリダイレクトされる' do
    fill_in 'ユーザー名', with: 'testname1'
    fill_in 'パスワード', with: 'hogehoge'
    click_button 'ログイン'
    expect(page).to have_current_path "/"
  end

  it 'ユーザー名を空欄でログインボタンを押すと「ユーザ名またはパスワードが違います」とflashメッセージが表示され、render :newされる' do
    fill_in 'ユーザー名', with: ''
    fill_in 'パスワード', with: 'hogehoge'
    click_button 'ログイン'
    expect(page).to have_current_path login_path
    expect(page).to have_content 'ユーザ名またはパスワードが違います'
  end

  it 'パスワードを空欄でログインボタンを押すと「ユーザ名またはパスワードが違います」とflashメッセージが表示され、render :newされる' do
    fill_in 'ユーザー名', with: 'testname1'
    fill_in 'パスワード', with: ''
    click_button 'ログイン'
    expect(page).to have_current_path login_path
    expect(page).to have_content 'ユーザ名またはパスワードが違います'
  end

  it '間違ったユーザー名を入れてログインボタンを押すと「ユーザ名またはパスワードが違います」とflashメッセージが表示され、render :newされる' do
    fill_in 'ユーザー名', with: 'testname2'
    fill_in 'パスワード', with: 'hogehoge'
    click_button 'ログイン'
    expect(page).to have_current_path login_path
    expect(page).to have_content 'ユーザ名またはパスワードが違います'
  end

  it '間違ったパスワードを入れてログインボタンを押すと「ユーザ名またはパスワードが違います」とflashメッセージが表示され、render :newされる' do
    fill_in 'ユーザー名', with: 'testname1'
    fill_in 'パスワード', with: 'foobar'
    click_button 'ログイン'
    expect(page).to have_current_path login_path
    expect(page).to have_content 'ユーザ名またはパスワードが違います'
  end
end
