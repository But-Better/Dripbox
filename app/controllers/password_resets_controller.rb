# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user
      user.send_password_reset
      flash[:notice] = 'E-mail sent with password reset instructions.'
    else
      flash[:notice] = 'E-mail not found'
    end
    redirect_to new_password_reset_url
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
      redirect_to new_password_reset_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end
end
