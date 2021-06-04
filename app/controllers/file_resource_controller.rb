class FileResourceController < ApplicationController

  def new
    @user = FileResource.new
  end

  def show
    @user = FileResource.find(params[:id])
  end

  def create
    @user = FileResource.new(user_params)
  end

  def destroy
    @user = FileResource.find(params[:id])
    @user.destroy
  end
end