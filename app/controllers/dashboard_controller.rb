class DashboardController < ApplicationController
  def index
    @files = FileResource.all
    @categories = Category.all
  end
end
