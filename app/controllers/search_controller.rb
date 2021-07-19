class SearchController < ApplicationController
  def index

    if !params[:search_query].empty?
      @suchEingabe = params[:search_query]
      @gefundeneFiles = UserResource.search(@suchEingabe)
    else
      @gefundeneFiles = UserResource.all
    end
  end
end
