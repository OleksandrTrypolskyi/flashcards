class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(user_path(@user), notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render 'new'
    end
  end

  def destroy
    logout
    session[:current_deck_id] = nil
    redirect_to(:root, notice: 'Logged out')
  end
end
