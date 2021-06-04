class CategoriesController < ApplicationController

  def new
    @user = Category.new
  end

  def show
    @user = Category.find(params[:id])
  end

  def create
    @user = Category.new(user_params)
  end

  def destroy
    @user = Category.find(params[:id])
    @user.destroy
  end
end