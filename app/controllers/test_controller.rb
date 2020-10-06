class TestController < ApplicationController
  include AjaxHelper
  before_action :require_login
  before_action :no_questions
  before_action :session_number_to_zero, only: [:new]

  def new
    session[:correct] = 0
    session[:incorrect] = 0
    session[:number] = 1
    session[:asked_question_ids] = []
    @number_of_questions = 5
    make_three_choices
  end

  def create
    if params[:correct_question_id] == params[:question_description_id]
      session[:correct] += 1
    else
      session[:incorrect] += 1
    end
    @number_of_questions = 5
    # 出題した問題数が、全問題数と同じになった時ランキング画面に移動
    if @number_of_questions == session[:number]
      rate = ((session[:correct] / 5.to_f) * 100).floor
      @user = current_user
      @user.update(highest_rate: rate) if rate > @user.highest_rate
      respond_to do |format|
        format.js { render ajax_redirect_to(ranking_test_index_path) }
      end
    end
    # 既出の単語のidを保存している
    session[:asked_question_ids] << params[:correct_question_id]
    session[:number] += 1
    make_three_choices
  end

  def ranking
    @rate = ((session[:correct] / 5.to_f) * 100).floor
    @users = User.order(highest_rate: "DESC")
    ranked_scores = User.order(highest_rate: "DESC").
      select(:highest_rate).map(&:highest_rate)
    ranked_scores = (ranked_scores << @rate).sort.reverse
    # 同率の時に順位が変わってしまう問題対策
    if @rate == current_user.highest_rate
      @your_rank = @users.index(current_user) + 1
    else
      @your_rank = ranked_scores.index(@rate) + 1
    end
  end

  private

  def no_questions
    if !Question.exists?
      redirect_to root_path, alert: '単語を作成してください'
    end
  end

  def make_three_choices
    questions = Question.all.includes([:question_similars])
    if session[:number] == 1
      @question = questions[rand(questions.count)]
    else
      destroy_questions = session[:asked_question_ids].map { |n| Question.find(n.to_i) }
      questions -= destroy_questions
      @question = questions.sample
      questions = Question.all.includes([:question_similars])
    end
    questions -= [@question]
    # rand関数で2つランダムで抜き出すの難しいのでsampleメソッドを使ってます。
    incorrect_questions = questions.sample(2)
    @question_descriptions = (incorrect_questions + [@question]).shuffle
  end
end
