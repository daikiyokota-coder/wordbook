class Question < ApplicationRecord
  has_many :question_similars, dependent: :destroy
  accepts_nested_attributes_for :question_similars, allow_destroy: true
  validates :question, presence: true
  validates :description, presence: true
end
