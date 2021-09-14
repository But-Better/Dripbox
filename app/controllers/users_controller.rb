# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :check_login

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
  end

  def edit
    current_user
  end

  def update
    current_user

    @current_user.update_attribute(:contact_status, !@current_user.contact_status)
    flash[:contactable_status] = @current_user.contact_status

    redirect_to edit_user_path
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
    else
      flash[:error] = 'Sorry. User does not exist'
    end
  end

  private

  def check_login
    redirect_to logout_url unless logged_in?
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
