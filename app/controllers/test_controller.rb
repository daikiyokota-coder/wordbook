class TestController < ApplicationController
  include AjaxHelper
  before_action :require_login
  before_action :no_questions
  before_action :session_number_to_zero, only: [:new]

  def new
    session[:correct] = 0
    session[:incorrect] = 0
    session[:number] = 1
    session[:question_ids] = []
    @number_of_questions = 5
    make_three_choices
  end

  def create
    if params[:correct_question_id] == params[:question_description_id]
      session[:correct] += 1
    else
      session[:incorrect] += 1
    end
    session[:number] += 1
    @number_of_questions = 5
    # 出題した問題数が、全問題数と同じになった時ランキング画面に移動
    if (@number_of_questions + 1) == session[:number]
      # 自分の最高正解率よりも高い場合はその正解率をcurrent_userのhighest_rateに保存する!!!!
      rate = ((session[:correct] / 5.to_f) * 100).floor
      @user = current_user
      @user.update(highest_rate: rate) if rate > @user.highest_rate
      respond_to do |format|
        format.js { render ajax_redirect_to(ranking_test_index_path) }
      end
    end
    # 既出の単語のidを保存している
    session[:question_ids] << params[:correct_question_id]
    make_three_choices
  end

  def ranking
    @rate = ((session[:correct] / 5.to_f) * 100).floor
    @users = User.order(highest_rate: "DESC")
    ranked_scores = User.all.order('highest_rate desc').select(:highest_rate).map(&:highest_rate)
    ranked_scores = (ranked_scores << @rate).sort.reverse
    @your_rank = ranked_scores.index(@rate) + 1
  end

  private

  def no_questions
    if !Question.exists?
      redirect_to root_path, alert: '単語を作成してください'
    end
  end

  def make_three_choices
    questions = Question.all
    if session[:number] == 1
      @question = questions.order("RANDOM()").first
      questions -= [@question]
      incorrect_questions = questions.sample(2)
      @question_descriptions = (incorrect_questions + [@question]).shuffle
    else
      destroy_questions = session[:question_ids].map { |n| Question.find(n.to_i) }
      questions -= destroy_questions
      # 残った単語の集合から出題する問題を抜き出す
      @question = questions.sample
      # 3択の残り2つを抜き出す
      questions = Question.all
      questions -= [@question]
      incorrect_questions = questions.sample(2)
      @question_descriptions = (incorrect_questions + [@question]).shuffle
    end
  end
end
