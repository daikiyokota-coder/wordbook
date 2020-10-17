require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @question = build(:question)
  end

  describe 'バリデーション' do
    it 'questionとdescriptionの2つの値が設定された単語は有効' do
      expect(@question.valid?).to eq(true)
    end

    it 'questionが設定されていない単語はNG' do
      @question.question = ''
      expect(@question.valid?).to eq(false)
    end

    it 'descriptionが設定されていない単語はNG' do
      @question.description = ''
      expect(@question.valid?).to eq(false)
    end
  end
end
