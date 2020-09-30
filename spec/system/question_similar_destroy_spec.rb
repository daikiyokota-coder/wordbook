require 'rails_helper'
RSpec.describe 'QuestionSimilarDestroy', type: :system do
  before do
    make_user_and_login
    @question = create(:question)
    create(:question_similar)
    visit question_path(@question)
  end

  describe '類義語の削除' do
    it '類義語の削除ボタンを押すと、類義語が1つ削除される', js: true do
      expect do
        click_link '削除する'
        page.accept_confirm "類義語を本当に削除しますか？"
        # expectを１つ以上入れないとダイアログが表示されてacceptされる前に次へ進んでしまう
        expect(page).to have_content "類義語を削除しました"
      end.to change(QuestionSimilar, :count).by(-1)
    end
  end
end
