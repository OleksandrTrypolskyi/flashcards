class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy]
  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def find_user
    if current_user
      @user = current_user
    else
      flash[:alert] = 'Please login or register'
      redirect_to root_path
    end
  end
end
