class QuestionSimilar < ApplicationRecord
  before_save :blank_to_nil
  belongs_to :question
  # validates :similar_word, presence: true

  def blank_to_nil
    if similar_word == ""
      self.similar_word = "#{question.question}の類義語"
    end
  end
end
