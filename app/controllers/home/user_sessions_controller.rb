# File for UserSessionsController
class Home::UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(dashboard_user_path(@user), success: 'Login successful')
    else
      flash.now[:warning] = 'Login failed'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to(:root, success: 'Logged out')
  end
end
