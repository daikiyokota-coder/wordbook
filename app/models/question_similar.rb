class QuestionSimilar < ApplicationRecord
  before_save :cancel_save
  belongs_to :question
  def cancel_save
    if similar_word == ""
      delete
    end
  end
end
