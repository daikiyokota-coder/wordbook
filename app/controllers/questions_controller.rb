class QuestionsController < ApplicationController
  before_action :require_login
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end
end
