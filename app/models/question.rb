class Question < ApplicationRecord
  has_many :question_similars, foreign_key: :question_id, dependent: :destroy
  validates :question, presence: true
  validates :description, presence: true
end
