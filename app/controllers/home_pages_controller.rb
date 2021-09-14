# frozen_string_literal: true

class HomePagesController < ApplicationController
  before_action :check_is_login

  def index; end

  def create
    # code here
  end

  private

  def check_is_login
    redirect_to dashboard_url if logged_in?
  end
end
