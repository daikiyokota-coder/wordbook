class TestController < ApplicationController
  include AjaxHelper
  before_action :require_login
  before_action :no_questions

  def new
    session[:correct] = 0
    session[:incorrect] = 0
    session[:number] = 1
    session[:question_ids] = []
    @number_of_questions = 3
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
    @number_of_questions = 3
    # 出題した問題数が、全問題数と同じになった時ランキング画面に移動
    if (@number_of_questions + 1) == session[:number]
      respond_to do |format|
        format.js { render ajax_redirect_to(ranking_test_index_path) }
      end
    end
    # 既出の単語のidを保存している
    session[:question_ids] << params[:correct_question_id]
    # 単語の集合から既出の単語を削除している
    questions = Question.all
    destroy_questions = session[:question_ids].map { |n| Question.find(n.to_i) }
    questions -= destroy_questions
    # 残った単語の集合から出題する問題を抜き出す
    @question = questions.sample
    # 3択の残り2つを抜き出す
    questions = Question.all
    questions -= [@question]
    incorrect_questions = questions.sample(2)
    @question_descriptions = incorrect_questions + [@question]
  end

  def ranking
  end

  private

  def no_questions
    if !Question.exists?
      redirect_to root_path, alert: '単語を作成してください'
    end
  end
end
