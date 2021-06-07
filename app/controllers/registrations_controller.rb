class RegistrationsController < ApplicationController
  def index
    @user = User.new
  end
end
