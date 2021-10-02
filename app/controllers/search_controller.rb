# frozen_string_literal: true

class SearchController < ApplicationController

  before_action :not_logged_in

  def index
    @suchEingabe = params[:search_query]

    @gefundeneFiles = if !@suchEingabe.empty?
                        UserResource.search(@suchEingabe)
                      else
                        UserResource.all
                      end
  end

  def not_logged_in
    redirect_to login_path unless logged_in?
  end
end
