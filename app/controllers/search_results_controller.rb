class SearchResultsController < ApplicationController
  def index
    @filesToFilter = FileResource.all
  end
end
