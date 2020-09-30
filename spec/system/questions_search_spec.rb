require 'rails_helper'
RSpec.describe 'QuestionsSearch', type: :system do
  before do
    make_user_and_login
    create(:question)
    create(:question, question: 'PHP', description: 'WEB開発言語')
    create(:question, question: 'Rails', description: 'Rubyのフレームワーク')
    visit questions_path
  end

  describe '単語の検索' do
    it '検索したワードを含む単語を検索結果ページに表示する' do
      find("#search_form").set("Ruby")
      click_button '検索'
      expect(page).to have_content 'Ruby'
      expect(page).not_to have_content 'PHP'
    end

    it '単語名の一部を入力して検索すると、その単語が含まれる単語が全て表示される' do
      find("#search_form").set("R")
      click_button '検索'
      expect(page).to have_content 'Ruby'
      expect(page).to have_content 'Rails'
      expect(page).not_to have_content 'PHP'
    end

    it '大文字小文字関係なく検索に反映される' do
      find("#search_form").set("php")
      click_button '検索'
      expect(page).to have_content 'PHP'
    end
  end
end
