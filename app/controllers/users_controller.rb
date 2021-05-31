class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    #redirect_back
  end

  private

  def user_params
    params.require(:user)
  end
end
