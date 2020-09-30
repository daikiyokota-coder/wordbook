require 'rails_helper'

RSpec.describe QuestionSimilar, type: :model do
  before do
    create(:question)
    @question_similar = build(:question_similar)
  end

  describe 'バリデーション' do
    it 'question_idとsimilar_wordの2つの値が設定された単語は有効' do
      expect(@question_similar.valid?).to eq(true)
    end

    it 'question_idが設定されていない単語はNG' do
      @question_similar.question_id = ''
      expect(@question_similar.valid?).to eq(false)
    end

    it 'similar_wordが設定されていない単語はNG' do
      @question_similar.similar_word = ''
      expect(@question_similar.valid?).to eq(false)
    end
  end
end
