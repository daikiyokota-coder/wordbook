class QuestionSimilar < ApplicationRecord
  belongs_to :question
  validates :similar_word, presence: true
end
