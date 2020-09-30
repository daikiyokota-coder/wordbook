class QuestionSimilarController < ApplicationController
  before_action :require_login
  def new
    @question_similar = Question_similar.new
  end

  def create
    @question_similar = Question_similar.new(question_similar_params)
    if @question_similar.save
      redirect_to questions_path, notice: '類義語を作成しました'
    else
      render 'new'
    end
  end

  def destroy
    @question_similar = Question_similar.find(params[:id])
    if @question_similar.destroy
      redirect_to questions_path, notice: '類義語を削除しました'
    else
      redirect_to root_url
    end
  end

  private

  def question_similar_params
    params.require(:question_similar).permit(:question_id, :similar_word)
  end
end
