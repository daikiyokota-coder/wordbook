class TestController < ApplicationController
  before_action :require_login

  def new
    session[:correct] = 0
    session[:incorrect] = 0
    questions = Question.all
    @question = questions.order("RANDOM()").first
    questions -= [@question]
    incorrect_questions = questions.sample(2)
    @question_descriptions = incorrect_questions + [@question]
  end

  def create
    if params[:correct_question_id] == params[:question_description_id]
      session[:correct] += 1
    else
      session[:incorrect] += 1
    end
    puts params[:correct_question_id]
    puts params[:question_description_id]
    redirect_to root_path
  end
end
