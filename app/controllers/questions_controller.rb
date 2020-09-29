class QuestionsController < ApplicationController
  before_action :require_login

  def search
    @questions = Question.where('question like ?', "%#{params[:search]}%")
  end

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
      render 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to questions_path, notice: '単語を編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      redirect_to questions_path, notice: '単語を削除しました'
    else
      redirect_to root_url
    end
  end

  private

  def question_params
    params.require(:question).permit(:question, :description)
  end
end
