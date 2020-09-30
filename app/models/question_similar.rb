class QuestionSimilar < ApplicationRecord
  belongs_to :question
  validates :similar_word, presence: true
  validates :question_id, presence: true
end
