class DashboardController < ApplicationController
  def index
    @files = FileResource.all.order
  end
end
