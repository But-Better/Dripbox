# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?, :deadline_checker

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    else
      @current_user = nil
    end
    logger.info "current_user #{@current_user}"
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user&.email_activate
      redirect_to dashboard_url
    else
      redirect_to root_url
    end
  end

  def deadline_checker
    Thread.new do
      current_user
      while true do
        deadline = @current_user.deadline
        if deadline < Time.now
          @current_user = nil
          session[:user_id] = nil
          break
        end
        sleep 1.seconds
      end
    end
  end
end
