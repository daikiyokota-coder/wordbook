class QuestionSimilar < ApplicationRecord
  validates :question_id, presence: true
  validates :similar_word, presence: true
end
