# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?
  around_action :switch_locale
  before_action :default_url_options

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale

    lang = I18n.config.available_locales

    unless locale.nil?
      lang.each do |value|
        if value.to_s == locale
          I18n.with_locale(locale, &action)
          return
        end
      end
      I18n.with_locale(I18n.default_locale, &action)
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

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
end
