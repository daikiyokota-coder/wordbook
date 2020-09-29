require 'rails_helper'
RSpec.describe 'QuestionsCreate', type: :system do
  before do
    create(:user, name: 'testname')
    visit login_path
    fill_in 'ユーザー名', with: 'testname'
    fill_in 'パスワード', with: 'hogehoge'
    click_button 'ログイン'
    visit new_question_path
  end

  describe '単語の作成' do
    it 'questionとdescriptionを設定して作成ボタンを押すと単語が1つ作成される' do
      expect(page).to have_current_path new_question_path
      expect do
        fill_in '単語', with: 'Ruby'
        fill_in '説明', with: 'プログラミング言語'
        click_button '作成'
      end.to change(Question, :count).by(1)
    end

    it '単語の作成に成功すると、questions_pathにリダイレクトされ、「単語を作成しました」とメッセージが表示される' do
      fill_in '単語', with: 'Ruby'
      fill_in '説明', with: 'プログラミング言語'
      click_button '作成'
      expect(page).to have_current_path questions_path
      expect(page).to have_content '単語を作成しました'
    end

    it '単語名を空欄で作成ボタンを押すと、単語は作成されず「単語を入力してください」とメッセージが表示される' do
      expect do
        fill_in '説明', with: 'プログラミング言語'
        click_button '作成'
      end.to change(Question, :count).by(0)
      expect(page).to have_content '単語を入力してください'
    end

    it '説明を空欄で作成ボタンを押すと、単語は作成されず「説明を入力してください」とメッセージが表示される' do
      expect do
        fill_in '単語', with: 'Ruby'
        click_button '作成'
      end.to change(Question, :count).by(0)
      expect(page).to have_content '説明を入力してください'
    end
  end
end
