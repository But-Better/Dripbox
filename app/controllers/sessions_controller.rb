# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user&.authenticate(params[:password])
      if user.email_confirmed
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        render 'user_mailer/Index'
      end
    else
      flash[:alert] = 'Email or password was invalid'
      redirect_to root_url
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
