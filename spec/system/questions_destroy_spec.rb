require 'rails_helper'
RSpec.describe 'QuestionsDestroy', type: :system do
  before do
    make_user_and_login
    create(:question)
    visit questions_path
  end

  describe '単語の削除' do
    it '単語の削除ボタンを押すと、単語が1つ削除される', js: true do
      expect do
        click_link '削除する'
        page.accept_confirm "単語を本当に削除しますか？"
        # expectを１つ以上入れないとダイアログが表示されてacceptされる前に次へ進んでしまう
        expect(page).to have_content "単語を削除しました"
      end.to change(Question, :count).by(-1)
    end
  end
end
