# frozen_string_literal: true

module SessionsHelper
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end
end
