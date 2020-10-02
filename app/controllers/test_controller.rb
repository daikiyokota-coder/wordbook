class TestController < ApplicationController
  before_action :require_login
  before_action :no_questions

  def new
    session[:correct] = 0
    session[:incorrect] = 0
    session[:number] = 1
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
    session[:number] += 1
    questions = Question.all
    @question = questions.order("RANDOM()").first
  end

  private

  def no_questions
    if !Question.exists?
      redirect_to root_path, alert: '単語を作成してください'
    end
  end
end
