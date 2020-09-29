class QuestionsController < ApplicationController
  before_action :require_login
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path, notice: '単語を作成しました'
    else
      render action: "new"
    end
  end

  private

  def question_params
    params.require(:question).permit(:question, :description)
  end
end
