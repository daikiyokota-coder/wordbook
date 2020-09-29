require 'rails_helper'
RSpec.describe 'QuestionsEdit', type: :system do
  before do
    make_user_and_login
    question = create(:question)
    visit edit_question_path(question)
  end

  describe '単語の編集' do
    it '単語名と説明の内容を変更して更新するボタンを押すと、questions_pathにリダイレクトされ、単語名と説明が変わっている' do
      fill_in '単語', with: 'PHP'
      fill_in '説明', with: 'WEB開発の言語'
      click_button '更新する'
      expect(page).to have_current_path questions_path
      expect(page).to have_content 'PHP'
      expect(page).to have_content 'WEB開発の言語'
    end
    it '単語の編集に成功すると、「単語を編集しました」とメッセージが表示される' do
      fill_in '単語', with: 'PHP'
      fill_in '説明', with: 'WEB開発の言語'
      click_button '更新する'
      expect(page).to have_content '単語を編集しました'
    end

    it '単語名を空欄で更新するボタンを押すと、更新は失敗し「単語を入力してください」とメッセージが表示される' do
      fill_in '単語', with: ''
      fill_in '説明', with: 'WEB開発の言語'
      click_button '更新する'
      expect(page).to have_content '単語を入力してください'
    end

    it '説明を空欄で更新するボタンを押すと、更新は失敗し「説明を入力してください」とメッセージが表示される' do
      fill_in '単語', with: 'PHP'
      fill_in '説明', with: ''
      click_button '更新する'
      expect(page).to have_content '説明を入力してください'
    end
  end
end
