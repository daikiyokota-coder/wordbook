class Question < ApplicationRecord
  before_save :cancel_save
  has_many :question_similars, dependent: :destroy
  accepts_nested_attributes_for :question_similars, allow_destroy: true
  validates :question, presence: true
  validates :description, presence: true
  def cancel_save
    question_similars.each do |question_similar|
      if question_similar.similar_word == ""
        question_similar.delete
      end
    end
  end
end
