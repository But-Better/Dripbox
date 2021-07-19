class SearchController < ApplicationController
  def index

    @suchEingabe = params[:search_query]

    if !@suchEingabe.empty?
      @gefundeneFiles = UserResource.search(@suchEingabe)
    else
      @gefundeneFiles = UserResource.all
    end
  end
end
