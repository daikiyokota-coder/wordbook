class QuestionSimilarController < ApplicationController
  before_action :require_login
  before_action :session_number_to_zero
  def new
    @question_similar = QuestionSimilar.new
  end

  def create
    @question = Question.find(params[:question_id])
    @question_similar = @question.question_similars.build(question_similar_params)
    if @question_similar.save
      redirect_to questions_path, notice: '類義語を作成しました'
    else
      render 'new'
    end
  end

  def destroy
    @question_similar = QuestionSimilar.find(params[:id])
    @question = @question_similar.question
    if @question_similar.destroy
      puts '削除されたよー'
    else
      redirect_to root_url
    end
  end

  private

  def question_similar_params
    params.require(:question_similar).permit(:question_id, :similar_word)
  end
end
