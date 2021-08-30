# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @suchEingabe = params[:search_query]

    @gefundeneFiles = if !@suchEingabe.empty?
                        UserResource.search(@suchEingabe)
                      else
                        UserResource.all
                      end
  end
end
