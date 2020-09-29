class Question < ApplicationRecord
  validates :question, presence: true
  validates :desctiption, presence: true
end
