class Question < ApplicationRecord
  has_many :question_similars, foreign_key: :question_id, dependent: :destroy
  accepts_nested_attributes_for :question_similars
  validates :question, presence: true
  validates :description, presence: true
end
