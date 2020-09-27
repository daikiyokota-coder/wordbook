class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: session_params[:name])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:danger] = 'ユーザ名またはパスワードが違います'
      render :new    
    end
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
