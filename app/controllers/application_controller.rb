class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'ログインしてください'
    end
  end

  def session_number_to_zero
    session[:number] = 0
  end
end
