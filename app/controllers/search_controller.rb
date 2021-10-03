# frozen_string_literal: true

class SearchController < ApplicationController

  before_action :not_logged_in

  def index
    current_user
    set_such_eingabe

    @gefundeneFiles = if !@suchEingabe.empty?
                        UserResource.search(@suchEingabe)
                      else
                        UserResource.all
                      end
  end

  def set_such_eingabe
    if !params[:search_query].present?
      @suchEingabe = ''
    else
      @suchEingabe = params[:search_query]
    end
  end

  def not_logged_in
    redirect_to login_path unless logged_in?
  end

end
