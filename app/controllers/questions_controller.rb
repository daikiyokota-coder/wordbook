class QuestionsController < ApplicationController
  before_action :require_login
  before_action :session_number_to_zero
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def search
    @questions = Question.where('question ilike ?', "%#{params[:search]}%")
  end

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    @question.question_similars.build
  end

  def create
    p params
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path, notice: '単語を作成しました'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update(question_update_params)
      redirect_to questions_path, notice: '単語を編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    session[:incorrect_question_ids].delete(@question.id.to_s)
    if @question.destroy
      redirect_to questions_path, notice: '単語を削除しました'
    else
      redirect_to root_url
    end
  end

  private

  def question_params
    params.require(:question).permit(:question, :description, question_similars_attributes:
      [:similar_word, :question_id])
  end

  def question_update_params
    params.require(:question).permit(:question, :description, question_similars_attributes:
      [:similar_word, :question_id, :_delete, :id])
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
