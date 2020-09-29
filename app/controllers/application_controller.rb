class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'ログインしてください'
    end
  end
end
