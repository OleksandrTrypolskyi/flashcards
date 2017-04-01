class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:password] == params[:password_confirmation]
      if @user = login(params[:email], params[:password])
        redirect_back_or_to(user_path(@user), notice: 'Login successful')
      else
        flash.now[:alert] = 'Login failed'
        render 'new'
      end
    else
      flash.now[:alert] = 'Password confirmation is wrong'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: 'Logged out')
  end
end
