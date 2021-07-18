class SearchResultsController < ApplicationController
  def index

    @suchEingabe = params[:search_query]

    if !params[:search_query].empty?
      @gefundeneFiles = UserResource.search(@suchEingabe)
    else
      @gefundeneFiles = UserResource.all
    end
  end
end
