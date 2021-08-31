# frozen_string_literal: true

class ApplicationController < ActionController::Base
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

  before_action :set_theme

  def set_theme
    if params[:theme].present?
      theme = params[:theme].to_sym
      # session[:theme] = theme
      cookies[:theme] = theme
      redirect_to(request.referrer || root_path)
    end
  end
end
