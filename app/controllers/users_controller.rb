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

  def check_owner
    if User.where(id: params[:id]).empty?
        flash[:alert] = "User with id: #{params[:id]} does not exist"
        flash[:notice] = 'You have access only to your own user'
        redirect_to user_path(current_user.id)
    elsif @user.id == User.find(params[:id]).id
     @user
    else
     flash.now[:alert] = 'You have access only to your own user'
    end
  end

  def find_user
    if current_user
      @user = current_user
      check_owner
    else
      flash[:alert] = 'Please login or register'
      redirect_to root_path
    end
  end
end
