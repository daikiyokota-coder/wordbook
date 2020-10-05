class TestController < ApplicationController
  include AjaxHelper
  before_action :require_login
  before_action :no_questions

  def new
    session[:correct] = 0
    session[:incorrect] = 0
    session[:number] = 1
    session[:question_ids] = []
    @number_of_questions = 5
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
    @number_of_questions = 5
    # 出題した問題数が、全問題数と同じになった時ランキング画面に移動
    if (@number_of_questions + 1) == session[:number]
      # 自分の最高正解率よりも高い場合はその正解率をcurrent_userのhighest_rateに保存する!!!!
      rate = ((session[:correct] / 5.to_f) * 100).floor
      puts rate
      puts 'rateあたいはいってる？'
      @user = User.find(current_user.id)
      @user.update(highest_rate: rate.to_i) if rate > @user.highest_rate
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
    @rate = ((session[:correct] / 5.to_f) * 100).floor
    # user = User.find(current_user.id)
    # users = User.where.not(highest_rate: 0, name: user.name)
    # user[:highest_rate] = @rate
    # users << user
    # @users = users.order(highest_rate: "DESC")
  end

  private

  def no_questions
    if !Question.exists?
      redirect_to root_path, alert: '単語を作成してください'
    end
  end
end
