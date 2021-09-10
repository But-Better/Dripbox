# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    @user_session = User.find_by_email(params[:email].downcase)
    auth_result = @user_session&.authenticate(params[:password])
    if auth_result
      if @user_session.email_confirmed
        session[:user_id] = @user_session.id
        redirect_to dashboard_path
      else
        render 'user_mailer/confirm_your_email'
      end
    else
      flash[:alert] = 'Email or password was invalid'
      render :new
    end
  end

  def destroy
    @current_user = nil
    session[:user_id] = nil
    redirect_to root_url
  end
end
