require 'rails_helper'
RSpec.describe 'QuestionsCreate', type: :system do
  before do
    make_user_and_login
    @question = create(:question)
    visit new_question_question_similar_path(@question)
  end

  describe '類義語の作成' do
    it '類義語を入力して作成ボタンを押すと類義語が1つ作成される' do
      expect(page).to have_current_path new_question_question_similar_path(@question)
      expect do
        fill_in '類義語', with: 'PHP'
        click_button '作成'
      end.to change(QuestionSimilar, :count).by(1)
    end

    it '類義語の作成に成功すると、questions_pathにリダイレクトされ、「類義語を作成しました」とメッセージが表示される' do
      fill_in '類義語', with: 'PHP'
      click_button '作成'
      expect(page).to have_current_path questions_path
      expect(page).to have_content '類義語を作成しました'
    end

    it '類義語を作成すると元となる単語のページに作成した類義語が追加されている' do
      fill_in '類義語', with: 'PHP'
      click_button '作成'
      click_link "#{@question.question}"
      expect(page).to have_current_path question_path(@question)
      expect(page).to have_content 'PHP'
    end

    it '類義語を入力せずに作成ボタンを押すと、「類義語を入力してください」とメッセージが表示される' do
      expect do
        click_button '作成'
      end.to change(QuestionSimilar, :count).by(0)
      expect(page).to have_content '類義語を入力してください'
    end
  end
end
