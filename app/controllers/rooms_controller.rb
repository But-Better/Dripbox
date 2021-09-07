class RoomsController < ApplicationController

  before_action :require_login

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  def index
  end
end
