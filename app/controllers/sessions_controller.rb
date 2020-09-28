class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: session_params[:name])
    if user&.authenticate(session_params[:password])
      log_in(user)
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:danger] = 'ユーザ名またはパスワードが違います'
      render :new    
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
