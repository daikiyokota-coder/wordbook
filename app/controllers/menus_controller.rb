class MenusController < ApplicationController
  before_action :session_number_to_zero
  def home
    # @incorrect_questions = session[:incorrect_question_ids].map { |n| Question.find(n.to_i) }
    # @incorrect_question = @incorrect_questions.sample if @incorrect_questions.present?
  end
end
