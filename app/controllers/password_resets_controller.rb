# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by_email(params[:email])
    @user&.send_password_reset
    redirect_to root_url
    flash.now[:notice] = 'E-mail sent with password reset instructions.'
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hour.ago
      flash[:notice] = 'Password reset has expired'
      redirect_to new_password_reset_path
    elsif @user.update(user_params)
      flash[:notice] = 'Password has been reset!'
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end
end
