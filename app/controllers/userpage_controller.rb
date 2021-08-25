class UserpageController < ApplicationController
  def index
    redirect_to registrations_index_path unless logged_in?
    current_user
  end
end
