class SearchResultsController < ApplicationController
  def index

    @suchEingabe = params[:search_query]

    if !params[:search_query].empty?
      @gefundeneFiles = UserResource.search(@suchEingabe)
    else
      @gefundeneFiles = UserResource.all
    end
    #Funktioniert:
    #@suchEingabe = params[:search_query]
    #@gefundeneFiles = UserResource.all.where("name LIKE ?","%#{@suchEingabe}%")


  end

end
