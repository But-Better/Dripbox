# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user.email_confirmed
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        redirect_to 'new'
      end
    else
      render 'user_mailer/Index'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
